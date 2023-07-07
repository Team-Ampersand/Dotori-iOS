import BaseFeature
import Configure
import DesignSystem
import Localization
import MSGLayout
import UIKit

final class HomeViewController: BaseViewController<HomeStore> {
    private enum Metric {
        static let horizontalPadding: CGFloat = 20
    }
    private let dotoriLabel = DotoriLabel(
        "DOTORI",
        textColor: .primary(.p10),
        font: .h3
    )
    private lazy var dotoriBarButtonItem = UIBarButtonItem(
        customView: dotoriLabel
    )
    private let timeHeaderView = TimeHeaderView()
    private let selfStudyApplicationCardView = ApplicationCardView(
        title: L10n.Home.selfStudyApplyTitle,
        applyText: L10n.Home.selfStudyApplyButtonTitle,
        maxApplyCount: 50
    )
    private let massageApplicationCardView = ApplicationCardView(
        title: L10n.Home.massageApplyTitle,
        applyText: L10n.Home.massageApplyButtonTitle,
        maxApplyCount: 5
    )

    override func addView() {
        view.addSubviews {
            timeHeaderView
            selfStudyApplicationCardView
            massageApplicationCardView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            timeHeaderView.layout
                .centerX(.toSuperview())
                .top(.to(view.safeAreaLayoutGuide).top, .equal(8))
                .horizontal(.toSuperview(), .equal(Metric.horizontalPadding))

            selfStudyApplicationCardView.layout
                .centerX(.toSuperview())
                .top(.to(timeHeaderView).bottom, .equal(12))
                .horizontal(.toSuperview(), .equal(Metric.horizontalPadding))

            massageApplicationCardView.layout
                .centerX(.toSuperview())
                .top(.to(selfStudyApplicationCardView).bottom, .equal(12))
                .horizontal(.toSuperview(), .equal(Metric.horizontalPadding))
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriBarButtonItem, animated: true)
    }
}
