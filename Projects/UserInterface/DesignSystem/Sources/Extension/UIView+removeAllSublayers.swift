import UIKit

public extension UIView {
    func removeAllSublayers() {
        self.layer.sublayers?.forEach { layer in
            if layer is CAShapeLayer {
                layer.removeFromSuperlayer()
            }
        }
    }
}
