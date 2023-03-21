import UIKit

public extension UIImage {
    func resize(to length: CGFloat) -> UIImage {
        let newSize = CGSize(width: length, height: length)
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }

        return image
    }

    func resize(width: CGFloat, height: CGFloat) -> UIImage {
        let newSize = CGSize(width: width, height: height)
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }

        return image
    }
}
