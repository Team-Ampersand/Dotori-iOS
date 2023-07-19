import UIKit

public extension UIStackView {
    func removeAllChildren() {
        self.arrangedSubviews
            .forEach(self.removeArrangedSubview(_:))

        self.subviews
            .forEach { $0.removeFromSuperview() }
    }
}
