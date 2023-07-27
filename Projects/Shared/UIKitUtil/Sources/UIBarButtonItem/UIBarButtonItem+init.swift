import UIKit

public extension UIBarButtonItem {
    convenience init(image: UIImage?) {
        self.init(image: image, style: .done, target: nil, action: nil)
    }
}
