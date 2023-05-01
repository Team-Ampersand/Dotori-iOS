import UIKit

public extension UIColor.DotoriColorSystem {
    enum Sub: DotoriColorable {
        case red
        case yellow
        case green
        case black
        case white
    }
}

public extension UIColor.DotoriColorSystem.Sub {
    var color: UIColor {
        switch self {
        case .red: return DesignSystemAsset.Sub.red.color
        case .yellow: return DesignSystemAsset.Sub.yellow.color
        case .green: return DesignSystemAsset.Sub.green.color
        case .black: return DesignSystemAsset.Sub.black.color
        case .white: return DesignSystemAsset.Sub.white.color
        }
    }
}
