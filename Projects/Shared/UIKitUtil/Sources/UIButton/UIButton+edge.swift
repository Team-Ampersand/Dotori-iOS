import UIKit

public extension UIButton {
    func setContentInsets(insets: UIEdgeInsets) {
        if self.configuration == nil {
            self.contentEdgeInsets = insets
        } else {
            self.configuration?.contentInsets = .init(
                top: insets.top,
                leading: insets.left,
                bottom: insets.bottom,
                trailing: insets.right
            )
        }
    }
}
