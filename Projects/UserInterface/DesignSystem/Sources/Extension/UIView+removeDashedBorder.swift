import UIKit

public extension UIView {
    func removeDashedBorder() {
        self.layer.sublayers?.forEach { layer in
            if layer is CAShapeLayer {
                layer.removeFromSuperlayer()
            }
        }
    }
}
