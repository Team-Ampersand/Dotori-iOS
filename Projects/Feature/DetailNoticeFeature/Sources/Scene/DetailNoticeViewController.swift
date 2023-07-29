import BaseDomainInterface
import BaseFeature
import ConcurrencyUtil
import DateUtility
import DesignSystem
import Localization
import MSGLayout
import NoticeDomainInterface
import Nuke
import UIKit
import UIKitUtil

final class DetailNoticeViewController: BaseStoredViewController<DetailNoticeStore> {
    private enum Metric {
        static let horizontalPadding: CGFloat = 20
    }
    private lazy var rewriteBarButton = UIBarButtonItem(
        image: .Dotori.pen.tintColor(color: .dotori(.neutral(.n10)))
    )
    private lazy var removeBarButton = UIBarButtonItem(
        image: .Dotori.trashcan.tintColor(color: .dotori(.sub(.red)))
    )
    private let signatureColorView = UIView()
        .set(\.cornerRadius, 6)
        .set(\.clipsToBounds, true)
    private let authorLabel = DotoriLabel(font: .h4)
    private let dateLabel = DotoriLabel(textColor: .neutral(.n20), font: .body2)
    private let titleLabel = DotoriLabel(textColor: .neutral(.n10), font: .h3)
    private lazy var headerStackView = VStackView(spacing: 8) {
        HStackView(spacing: 8) {
            signatureColorView
                .width(12)
                .height(12)

            authorLabel

            SpacerView()

            dateLabel
        }
        .alignment(.center)

        titleLabel
    }
    private let contentLabel = DotoriLabel(font: .body1)
        .set(\.numberOfLines, 0)
        .set(\.clipsToBounds, true)
    private lazy var contentStackView = VStackView(spacing: 16) {
        contentLabel
    }
        .margin(.axes(vertical: 12, horizontal: 16))
        .set(\.backgroundColor, .dotori(.background(.bg)))
        .set(\.cornerRadius, 8)

    override func setLayout() {
        MSGLayout.stackedScrollLayout(self.view) {
            VStackView(spacing: 24) {
                headerStackView

                contentStackView
            }
            .margin(.axes(vertical: 16, horizontal: 20))
        }
    }

    override func configureViewController() {
        self.view.backgroundColor = .dotori(.background(.card))
    }

    override func bindAction() {
        viewDidLoadPublisher
            .map { Store.Action.viewDidLoad }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        viewWillAppearPublisher
            .map { Store.Action.viewWillAppear }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        removeBarButton.tapPublisher
            .map { Store.Action.removeBarButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }

    override func bindState() {
        let sharedState = store.state.share()
            .receive(on: DispatchQueue.main)

        sharedState
            .compactMap(\.detailNotice)
            .sink(with: self, receiveValue: { owner, notice in
                owner.bindNotice(notice: notice)
            })
            .store(in: &subscription)

        sharedState
            .map(\.currentUserRole)
            .filter { $0 != .member }
            .sink(with: self, receiveValue: { owner, _ in
                owner.navigationItem.setRightBarButtonItems(
                    [owner.removeBarButton, owner.rewriteBarButton],
                    animated: true
                )
            })
            .store(in: &subscription)
    }
}

private extension DetailNoticeViewController {
    func bindNotice(notice: DetailNoticeModel) {
        signatureColorView.backgroundColor = notice.role.toSignatureColor
        authorLabel.text = notice.role.toAuthorString
        dateLabel.text = (notice.modifiedDate ?? notice.createdDate)
            .toStringWithCustomFormat(L10n.Notice.detailNoticeDateFormat)
        contentLabel.text = notice.content

        contentStackView.removeAllChildren()
        contentStackView.addArrangedSubview(contentLabel)
        Task {
            let imageViews = try await notice.images
                .map { image in
                    ImageRequest(
                        url: URL(string: image.imageURL),
                        processors: [
                            .gaussianBlur(),
                            .roundedCorners(radius: 8)
                        ],
                        options: .disableDiskCache
                    )
                }
                .concurrentMap { try await ImagePipeline.shared.image(for: $0) }
                .map { UIImageView(image: $0) }
            self.contentStackView.addArrangedSubviews(views: imageViews)
        }
    }
}

private extension UserRoleType {
    var toAuthorString: String {
        switch self {
        case .admin: return L10n.Notice.authorRoleAdmin
        case .councillor: return L10n.Notice.authorRoleCouncillor
        case .developer: return L10n.Notice.authorRoleDeveloper
        case .member: return L10n.Notice.authorRoleMember
        }
    }

    var toSignatureColor: UIColor {
        switch self {
        case .admin: return .dotori(.sub(.yellow))
        case .member: return .dotori(.neutral(.n20))
        case .councillor: return .dotori(.sub(.red))
        case .developer: return .dotori(.primary(.p10))
        }
    }
}
