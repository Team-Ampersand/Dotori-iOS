import BaseFeature
import Configure
import DesignSystem
import Localization
import MSGLayout
import UIKit

final class HomeViewController: BaseViewController<HomeStore> {
    private let dotoriLabel = UILabel()
        .set(\.text, "DOTORI")
        .set(\.textColor, .dotori(.primary(.p10)))
        .set(\.font, .dotori(.h3))
    private lazy var dotoriBarButtonItem = UIBarButtonItem(customView: dotoriLabel)
    private let timeHeaderView = TimeHeaderView()
    private let selfStudyApplicationCardView = ApplicationCardView(
        title: L10n.Home.selfStudyApplyTitle,
        applyText: L10n.Home.selfStudyApplyButtonTitle,
        maxApplyCount: 50
    )
    private let massageApplicationCardView = ApplicationCardView(
        title: L10n.Home.massageApplyTitle,
        applyText: L10n.Home.massageApplyButtonTitle,
        maxApplyCount: 50
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
                .horizontal(.toSuperview(), .equal(20))

            selfStudyApplicationCardView.layout
                .centerX(.toSuperview())
                .top(.to(timeHeaderView).bottom, .equal(12))
                .horizontal(.toSuperview(), .equal(20))

            massageApplicationCardView.layout
                .centerX(.toSuperview())
                .top(.to(selfStudyApplicationCardView).bottom, .equal(12))
                .horizontal(.toSuperview(), .equal(20))
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriBarButtonItem, animated: true)
    }
}
