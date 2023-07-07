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

    override func addView() {
        view.addSubviews {
            timeHeaderView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            timeHeaderView.layout
                .centerX(.toSuperview())
                .top(.to(view.safeAreaLayoutGuide).top, .equal(8))
                .horizontal(.toSuperview(), .equal(20))
                .height(100)
        }
    }

    override func configureViewController() {
        view.backgroundColor = .dotori(.background(.bg))
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriBarButtonItem, animated: true)
    }
}
