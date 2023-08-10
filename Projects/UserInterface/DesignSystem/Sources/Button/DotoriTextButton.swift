import UIKit

public final class DotoriTextButton: UIButton {
    public init(
        _ text: String = "",
        textColor: UIColor.DotoriColorSystem = .neutral(.n10),
        font: UIFont.DotoriFontSystem = .subtitle2
    ) {
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.setTitleColor(.dotori(textColor), for: .normal)
        self.setTitleColor(.dotori(textColor).withAlphaComponent(0.7), for: .highlighted)
        self.titleLabel?.font = .dotori(font)
        self.imageView?.tintColor = .dotori(textColor)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
