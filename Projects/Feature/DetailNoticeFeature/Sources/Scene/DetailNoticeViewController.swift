import BaseFeature
import DesignSystem
import MSGLayout
import UIKit
import UIKitUtil

final class DetailNoticeViewController: BaseStoredViewController<DetailNoticeStore> {
    private enum Metric {
        static let horizontalPadding: CGFloat = 20
    }
    private let rewriteBarButton = UIBarButtonItem(
        image: .Dotori.pen.tintColor(color: .dotori(.neutral(.n10)))
    )
    private let removeBarButton = UIBarButtonItem(
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
    private let contentLabel = DotoriLabel("", font: .body1)
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

    override func configureNavigation() {
        self.navigationItem.setRightBarButtonItems([removeBarButton, rewriteBarButton], animated: true)
    }
}
