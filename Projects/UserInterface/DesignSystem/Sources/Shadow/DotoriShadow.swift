import UIKit

public enum DotoriShadow {
    public static func toastShadow(toast: UIView) {
        toast.layer.shadowColor = UIColor.dotori(.sub(.black)).cgColor
        toast.layer.shadowOpacity = 0.04
        toast.layer.shadowOffset = .init(width: 0, height: 8)
        toast.layer.shadowRadius = 24
    }

    public static func cardShadow(card: UIView) {
        card.layer.shadowColor = UIColor.dotori(.sub(.black)).cgColor
        card.layer.shadowOpacity = 0.04
        card.layer.shadowOffset = .init(width: 0, height: 8)
        card.layer.shadowRadius = 24
    }
}
