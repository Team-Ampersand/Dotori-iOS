import UIKit

public extension UIColor.DotoriColorSystem {
    enum Primary: DotoriColorable {
        case p10
        case p20
        case p30
    }
}

public extension UIColor.DotoriColorSystem.Primary {
    var color: UIColor {
        switch self {
        case .p10: return DesignSystemAsset.Primary.p10.color
        case .p20: return DesignSystemAsset.Primary.p20.color
        case .p30: return DesignSystemAsset.Primary.p30.color
        }
    }
}
