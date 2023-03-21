import UIKit

public extension UIImage {
    static let eye = DesignSystemAsset.DotoriIcon.eye.image
    static let eyeSlash = DesignSystemAsset.DotoriIcon.eyeSlash.image
    static let lock = DesignSystemAsset.DotoriIcon.lock.image
    static let person = DesignSystemAsset.DotoriIcon.person.image
    static let xmarkCircle = DesignSystemAsset.DotoriIcon.xmarkCircle.image
}

internal extension UIImage {
    func resize(to length: CGFloat) -> UIImage {
        let newSize = CGSize(width: length, height: length)
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }

        return image
    }
}
