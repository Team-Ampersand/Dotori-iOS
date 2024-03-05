import BaseFeature
import Combine
import DesignSystem
import Foundation
import Localization
import MSGLayout
import UIKit
import UIKitUtil

final class ProfileImageViewController: BaseStoredModalViewController<ProfileImageStore> {
    private enum Metric {
        static let padding: CGFloat = 24
    }
    private let editProfileTitleLabel = DotoriLabel(L10n.ProfileImage.selectProfileImage)
    private let xmarkButton = DotoriIconButton(image: .Dotori.xmark)
    private let addImageButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "camera.fill")
        configuration.imagePlacement = .top
        configuration.imagePadding = 10
        configuration.background.backgroundColor = .dotori(.background(.bg))
        configuration.title = "이미지 추가"
        configuration.titleAlignment = .center
        configuration.attributedTitle?.foregroundColor = .dotori(.neutral(.n20))
        configuration.attributedTitle?.font = .dotori(.caption)
        configuration.baseForegroundColor = .dotori(.primary(.p30))
        configuration.background.cornerRadius = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 112, leading: 108, bottom: 104, trailing: 108)
        let button = UIButton(configuration: configuration)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let addImageLabel = DotoriLabel(L10n.ProfileImage.addImage)
    private let editButton = DotoriButton(text: L10n.Global.editButtonTitle)
    private let confirmButton = DotoriButton(text: L10n.Global.confirmButtonTitle)
    override func addView() {
        super.addView()
    }
    override func setLayout() {
        MSGLayout.buildLayout {
            contentView.layout
                .center(.toSuperview())
                .horizontal(.toSuperview(), .equal(20))
        }
        MSGLayout.stackedLayout(self.contentView) {
            VStackView(spacing: 24) {
                HStackView {
                    editProfileTitleLabel
                    xmarkButton
                }
                addImageButton
                    .width(272)
                    .height(266)
                //                HStackView(spacing: 8){
                //                    editButton
                //
                //                    confirmButton
                //                }
            }
            .margin(.all(Metric.padding))
        }
        .distribution(.fill)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setNeedsLayout()
        addImageButton.addDashedBorder()
    }

    override func bindAction() {
        //        viewWillAppearPublisher
        //            .map { Store.Action.fetchMyViolationList }
        //            .sink(receiveValue: store.send(_:))
        //            .store(in: &subscription)

        xmarkButton.tapPublisher
            .map { Store.Action.xmarkButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        view.tapGesturePublisher()
            .map { _ in Store.Action.dimmedBackgroundDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        confirmButton.tapPublisher
            .map { Store.Action.confirmButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }

    override func bindState() {
        let sharedState = store.state.share()
            .receive(on: DispatchQueue.main)

        //        sharedState
        //            .map(\.violationList)
        //            .map { [GenericSectionModel(items: $0)] }
        //            .sink(receiveValue: violationHistoryTableAdapter.updateSections(sections:))
        //            .store(in: &subscription)

        //        sharedState
        //            .map(\.violationList)
        //            .map(\.count)
        //            .map { $0 == 0 }
        //            .sink(with: self, receiveValue: { owner, violationIsEmpty in
        //                owner.violationHistoryTableView.backgroundColor = violationIsEmpty
        //                    ? .dotori(.background(.bg))
        //                    : .clear
        //                owner.emptyViolationLabel.isHidden = !violationIsEmpty
        //            })
        //            .store(in: &subscription)
    }
}
