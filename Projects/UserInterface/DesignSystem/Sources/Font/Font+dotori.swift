import UIKit

public extension UIFont {
    enum DotoriFontSystem: DotoriFontable {
        case h1
        case h2
        case h3
        case h4
        case subtitle1
        case subtitle2
        case subtitle3
        case smalltitle
        case body1
        case body2
        case caption
    }

    static func dotori(_ style: DotoriFontSystem) -> UIFont {
        return style.font
    }
}

public extension UIFont.DotoriFontSystem {
    var font: UIFont {
        switch self {
        case .h1:
            return UIFont(font: DesignSystemFontFamily.Suit.bold, size: 48) ?? .init()

        case .h2:
            return UIFont(font: DesignSystemFontFamily.Suit.bold, size: 32) ?? .init()

        case .h3:
            return UIFont(font: DesignSystemFontFamily.Suit.bold, size: 24) ?? .init()

        case .h4:
            return UIFont(font: DesignSystemFontFamily.Suit.bold, size: 20) ?? .init()

        case .subtitle1:
            return UIFont(font: DesignSystemFontFamily.Suit.bold, size: 18) ?? .init()

        case .subtitle2:
            return UIFont(font: DesignSystemFontFamily.Suit.bold, size: 16) ?? .init()

        case .subtitle3:
            return UIFont(font: DesignSystemFontFamily.Suit.medium, size: 18) ?? .init()

        case .smalltitle:
            return UIFont(font: DesignSystemFontFamily.Suit.semiBold, size: 14) ?? .init()

        case .body1:
            return UIFont(font: DesignSystemFontFamily.Suit.medium, size: 16) ?? .init()

        case .body2:
            return UIFont(font: DesignSystemFontFamily.Suit.medium, size: 14) ?? .init()

        case .caption:
            return UIFont(font: DesignSystemFontFamily.Suit.medium, size: 12) ?? .init()
        }
    }
}
