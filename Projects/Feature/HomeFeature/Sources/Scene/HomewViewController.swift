import BaseFeature
import Configure
import UIKit
import MSGLayout

final class HomeViewController: BaseViewController<HomeStore> {
    private let titleLabel = UILabel()
        .set(\.text, "HI")
        .set(\.textColor, .dotori(.system(.error)))
        .set(\.font, .dotori(.h4))
    private let dotoriLabel = UILabel()
        .set(\.text, "DOTORI")
        .set(\.textColor, .dotori(.primary(.p10)))
        .set(\.font, .dotori(.h3))
    private lazy var dotoriBarButtonItem = UIBarButtonItem(customView: dotoriLabel)

    override func addView() {
        view.addSubviews {
            titleLabel
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            titleLabel.layout
                .center(.toSuperview())
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriBarButtonItem, animated: true)
    }
}
