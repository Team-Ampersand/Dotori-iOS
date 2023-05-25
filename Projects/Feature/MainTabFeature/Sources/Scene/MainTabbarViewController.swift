import BaseFeature
import DesignSystem
import UIKit

final class MainTabbarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
}

private extension MainTabbarViewController {
    func configureViewController() {
        self.tabBar.tintColor = .dotori(.primary(.p10))
    }
}
