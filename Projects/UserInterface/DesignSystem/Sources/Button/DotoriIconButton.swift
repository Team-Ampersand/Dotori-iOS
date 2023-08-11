import UIKit

public final class DotoriIconButton: UIButton {
    public init(image: UIImage?) {
        super.init(frame: .zero)
        self.setImage(image, for: .normal)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
