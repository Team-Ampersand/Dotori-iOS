import BaseFeature
import DesignSystem
import Localization
import MSGLayout
import UIKit

final class NoticeViewController: BaseViewController<NoticeStore> {
    private enum Metric {
        static let horizontalPadding: CGFloat = 20
        static let spacing: CGFloat = 12
    }
    private let dotoriBarButton = DotoriBarButtonItem()
    private let entireTitleLabel = DotoriLabel(L10n.Notice.entireTitle, font: .subtitle1)

    override func addView() {
        view.addSubviews {
            entireTitleLabel
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            entireTitleLabel.layout
                .top(.to(view.safeAreaLayoutGuide), .equal(13))
                .leading(.toSuperview(), .equal(Metric.horizontalPadding))
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriBarButton, animated: true)
    }
}
