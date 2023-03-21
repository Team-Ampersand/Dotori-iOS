import UIKit

public enum DotoriShadow {
    static func toastShadow(toast: UIView) {
        toast.layer.shadowColor = UIColor.dotori(.sub(.black)).cgColor
        toast.layer.shadowOpacity = 0.04
        toast.layer.shadowOffset = .init(width: 0, height: 8)
        toast.layer.shadowRadius = 24
    }
}
