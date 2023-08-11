import UIKit

public extension UIColor {
    enum DotoriColorSystem {
        case primary(Primary)
        case neutral(Neutral)
        case system(System)
        case sub(Sub)
        case background(Background)
    }

    static func dotori(_ style: DotoriColorSystem) -> UIColor {
        switch style {
        case let .primary(colorable as DotoriColorable),
             let .neutral(colorable as DotoriColorable),
             let .system(colorable as DotoriColorable),
             let .sub(colorable as DotoriColorable),
             let .background(colorable as DotoriColorable):
            return colorable.color
        }
    }
}
