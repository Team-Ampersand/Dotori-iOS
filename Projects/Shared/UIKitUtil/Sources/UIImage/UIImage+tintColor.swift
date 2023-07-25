import UIKit

public extension UIImage {
    func tintColor(color: UIColor) -> UIImage? {
        self.withTintColor(color, renderingMode: .alwaysOriginal)
    }
}
