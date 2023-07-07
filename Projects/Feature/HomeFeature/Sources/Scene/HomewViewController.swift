import BaseFeature
import Configure
import DesignSystem
import UIKit
import MSGLayout

final class HomeViewController: BaseViewController<HomeStore> {
    private let dotoriLabel = UILabel()
        .set(\.text, "DOTORI")
        .set(\.textColor, .dotori(.primary(.p10)))
        .set(\.font, .dotori(.h3))
    private lazy var dotoriBarButtonItem = UIBarButtonItem(customView: dotoriLabel)
    private let timeHeaderView = TimeHeaderView()
    private let selfStudyApplicationCardView = ApplicationCardView(
        title: "자습신청",
        applyText: "자습신청",
        maxApplyCount: 50
    )

    override func addView() {
        view.addSubviews {
            timeHeaderView
            selfStudyApplicationCardView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            timeHeaderView.layout
                .centerX(.toSuperview())
                .top(.to(view.safeAreaLayoutGuide).top, .equal(8))
                .horizontal(.toSuperview(), .equal(20))
                .height(100)

            selfStudyApplicationCardView.layout
                .centerX(.toSuperview())
                .top(.to(timeHeaderView).bottom, .equal(12))
                .horizontal(.toSuperview(), .equal(20))
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriBarButtonItem, animated: true)
    }
}
