import BaseFeature
import Configure
import DesignSystem
import Localization
import MSGLayout
import UIKit

final class HomeViewController: BaseViewController<HomeStore> {
    private enum Metric {
        static let horizontalPadding: CGFloat = 20
        static let spacing: CGFloat = 12
    }
    private let scrollView = UIScrollView()
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
    private let mealCardView = MealCardView()

    override func addView() {
        view.addSubviews(scrollView)
        scrollView.addSubviews {
            timeHeaderView
            selfStudyApplicationCardView
            massageApplicationCardView
            mealCardView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            scrollView.layout
                .edges(.toSuperview())

            timeHeaderView.layout
                .centerX(.toSuperview())
                .top(.toSuperview(), .equal(8))
                .horizontal(.toSuperview(), .equal(Metric.horizontalPadding))

            selfStudyApplicationCardView.layout
                .centerX(.toSuperview())
                .top(.to(timeHeaderView).bottom, .equal(Metric.spacing))
                .horizontal(.toSuperview(), .equal(Metric.horizontalPadding))

            massageApplicationCardView.layout
                .centerX(.toSuperview())
                .top(.to(selfStudyApplicationCardView).bottom, .equal(Metric.spacing))
                .horizontal(.toSuperview(), .equal(Metric.horizontalPadding))

            mealCardView.layout
                .centerX(.toSuperview())
                .top(.to(massageApplicationCardView).bottom, .equal(Metric.spacing))
                .horizontal(.toSuperview(), .equal(Metric.horizontalPadding))
                .bottom(.toSuperview(), .equal(-32))
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriBarButtonItem, animated: true)
    }
}
