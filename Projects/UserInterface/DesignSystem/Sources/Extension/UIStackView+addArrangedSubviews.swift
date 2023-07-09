import UIKit

public extension UIStackView {
    func addArrangedSubviews(views: UIView...) {
        views.forEach(self.addArrangedSubview(_:))
    }

    func addArrangedSubviews(views: [UIView]) {
        views.forEach(self.addArrangedSubview(_:))
    }
}
