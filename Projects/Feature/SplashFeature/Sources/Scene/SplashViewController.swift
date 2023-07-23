import BaseFeature
import DesignSystem
import MSGLayout
import UIKit

final class SplashViewController: BaseViewController<SplashStore> {
    private let dotoriLogoImageView = DotoriIconView(image: .Dotori.dotori)

    override func addView() {
        view.addSubviews {
            dotoriLogoImageView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            dotoriLogoImageView
        }
    }
}
