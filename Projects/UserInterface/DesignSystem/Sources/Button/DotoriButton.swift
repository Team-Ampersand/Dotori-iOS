import UIKit

public final class DotoriButton: UIButton {
    public override var isEnabled: Bool {
        didSet { setNeedsDisplay() }
    }
    public override var isHighlighted: Bool {
        didSet { setNeedsDisplay() }
    }
    private let text: String

    public init(text: String = "") {
        self.text = text
        super.init(frame: .zero)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        setButtonColor()
    }
}

private extension DotoriButton {
    func setupButton() {
        self.clipsToBounds = true
        self.titleLabel?.font = .dotori(.subtitle2)
        self.setTitle(text, for: .normal)
        self.layer.cornerRadius = 8
        self.heightAnchor.constraint(
            equalToConstant: DotoriButtonProperty.Dimension.buttonHeight
        ).isActive = true
    }

    func setButtonColor() {
        let textForegroundColor: UIColor
        let backgroundColor: UIColor
        if isEnabled {
            textForegroundColor = .dotori(.sub(.white))
            backgroundColor = .dotori(.primary(.p10))
        } else {
            textForegroundColor = .dotori(.neutral(.n50))
            backgroundColor = .dotori(.primary(.p30))
        }
        setTitleColor(textForegroundColor, for: .normal)
        setTitleColor(textForegroundColor.withAlphaComponent(0.8), for: .highlighted)
        setBackgroundColor(backgroundColor, for: .normal)
        setBackgroundColor(backgroundColor.withAlphaComponent(0.8), for: .highlighted)
    }
}
