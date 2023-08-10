import UIKit

public extension UIColor.DotoriColorSystem {
    enum Background: DotoriColorable {
        case bg
        case card
    }
}

public extension UIColor.DotoriColorSystem.Background {
    var color: UIColor {
        switch self {
        case .bg: return DesignSystemAsset.Background.bg.color
        case .card: return DesignSystemAsset.Background.card.color
        }
    }
}
