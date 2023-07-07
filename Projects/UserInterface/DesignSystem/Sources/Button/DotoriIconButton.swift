import UIKit

public final class DotoriIconButton: UIButton {
    public init(image: UIImage?) {
        super.init(frame: .zero)
        self.setImage(image, for: .normal)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
