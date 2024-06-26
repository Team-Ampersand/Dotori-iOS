import UIKit
import UIKitUtil

public final class DotoriOutlineButton: UIButton {
    override public var isHighlighted: Bool {
        didSet { setNeedsDisplay() }
    }

    private let text: String

    public init(text: String = "") {
        self.text = text
        super.init(frame: .zero)
        setupButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        setButtonColor()
    }
}

private extension DotoriOutlineButton {
    func setupButton() {
        self.clipsToBounds = true
        self.titleLabel?.font = .dotori(.subtitle2)
        self.setTitle(text, for: .normal)
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.setContentInsets(insets: .init(top: 14, left: 0, bottom: 14, right: 0))
    }

    func setButtonColor() {
        let textForegroundColor: UIColor = .dotori(.neutral(.n20))
        let backgroundColor: UIColor = .clear
        let borderColor: UIColor
        if isHighlighted {
            borderColor = .dotori(.neutral(.n30)).withAlphaComponent(0.8)
        } else {
            borderColor = .dotori(.neutral(.n30))
        }
        setTitleColor(textForegroundColor, for: .normal)
        setTitleColor(textForegroundColor.withAlphaComponent(1.2), for: .highlighted)
        setBackgroundColor(backgroundColor, for: .normal)
        setBackgroundColor(backgroundColor.withAlphaComponent(0.1), for: .highlighted)
        self.layer.borderColor = borderColor.cgColor
    }
}
