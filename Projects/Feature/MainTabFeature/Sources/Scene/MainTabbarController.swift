import BaseFeature
import DesignSystem
import UIKit

final class MainTabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
}

private extension MainTabbarController {
    func configureViewController() {
        self.tabBar.tintColor = .dotori(.primary(.p10))
    }
}
