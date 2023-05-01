import UIKit

public extension UIColor.DotoriColorSystem {
    enum System: DotoriColorable {
        case error
        case positive
    }
}

public extension UIColor.DotoriColorSystem.System {
    var color: UIColor {
        switch self {
        case .error: return DesignSystemAsset.System.error.color
        case .positive: return DesignSystemAsset.System.positive.color
        }
    }
}
