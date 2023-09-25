import UIKit

public extension UINavigationItem {
    func configDotoriBackButton(title: String = "") {
        let backButton = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        backButton.tintColor = .dotori(.neutral(.n20))
        self.backBarButtonItem = backButton
    }
}
