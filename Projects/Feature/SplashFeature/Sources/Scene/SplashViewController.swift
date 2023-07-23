import BaseFeature
import DesignSystem
import MSGLayout
import UIKit

final class SplashViewController: BaseViewController<SplashStore> {
    private let dotoriLogoImageView = DotoriIconView(
        size: .custom(.init(width: 108,height: 108)),
        image: .Dotori.dotori
    )

    override func addView() {
        view.addSubviews {
            dotoriLogoImageView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            dotoriLogoImageView.layout
                .center(.toSuperview())
        }
    }

    override func configureViewController() {
        self.view.backgroundColor = .dotori(.background(.bg))
    }
}
