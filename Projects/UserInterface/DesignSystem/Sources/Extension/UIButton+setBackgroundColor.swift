import UIKit

public extension UIButton {
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 1.0, height: 1.0))

        let image = render.image { context in
            if let color = color {
                color.setFill()
            } else {
                UIColor.clear.setFill()
            }
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        }

        self.setBackgroundImage(image, for: state)
    }
}
