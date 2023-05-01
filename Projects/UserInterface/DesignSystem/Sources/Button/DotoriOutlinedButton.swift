import UIKit

public final class DotoriOutlineButton: UIButton {
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

private extension DotoriOutlineButton {
    func setupButton() {
        self.clipsToBounds = true
        self.titleLabel?.font = .dotori(.subtitle2)
        self.setTitle(text, for: .normal)
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.heightAnchor.constraint(
            equalToConstant: DotoriButtonProperty.Dimension.buttonHeight
        ).isActive = true
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
