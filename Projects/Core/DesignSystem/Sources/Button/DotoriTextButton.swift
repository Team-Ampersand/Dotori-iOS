import UIKit

public final class DotoriTextButton: UIButton {
    public init(
        text: String,
        color: UIColor,
        font: UIFont
    ) {
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.setTitleColor(color, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
