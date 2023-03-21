import UIKit

public final class DotoriIconTextField: UITextField {
    public override var placeholder: String? {
        didSet { setNeedsDisplay() }
    }
    private var cleanrButtonWidth: CGFloat {
        clearButtonRect(forBounds: bounds).width
    }
    private var iconViweWidth: CGFloat {
        iconView.frame.width
    }
    private let iconView: DotoriIconView

    public init(
        placeholder: String? = "",
        icon: UIImage
    ) {
        let dotoriIconView = DotoriIconView()
        dotoriIconView.image = icon.withRenderingMode(.alwaysTemplate)
        dotoriIconView.tintColor = .dotori(.neutral(.n30))
        self.iconView = dotoriIconView
        super.init(frame: .zero)
        setupTextField()
        self.placeholder = placeholder
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func becomeFirstResponder() -> Bool {
        let didBecomeFirstResponder = super.becomeFirstResponder()
        if didBecomeFirstResponder {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.dotori(.primary(.p10)).cgColor
            self.iconView.tintColor = .dotori(.neutral(.n10))
        }
        return didBecomeFirstResponder
    }

    public override func resignFirstResponder() -> Bool {
        let didResignFirstResponder = super.resignFirstResponder()
        if didResignFirstResponder {
            self.layer.borderWidth = 0
            self.layer.borderColor = nil
            self.iconView.tintColor = .dotori(.neutral(.n30))
        }
        return didResignFirstResponder
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        setPlaceholderTextColor()
    }

    public override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        return rect.offsetBy(
            dx: -(
                DotoriTextFieldProperty.Dimension.rightMargin
                - DotoriTextFieldProperty.Dimension.clearButtonDefaultRightMargin
            ),
            dy: 0
        )
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textAreaEdges())
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textAreaEdges())
    }
}

private extension DotoriIconTextField {
    func setupTextField() {
        self.backgroundColor = .dotori(.neutral(.n50))
        self.font = .dotori(.body1)
        self.tintColor = .dotori(.neutral(.n10))
        self.clearButtonMode = .whileEditing
        self.clipsToBounds = true
        self.layer.cornerRadius = 8

        self.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: DotoriTextFieldProperty.Dimension.leftMargin
        ).isActive = true
        iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        self.heightAnchor.constraint(
            equalToConstant: DotoriTextFieldProperty.Dimension.textFieldHeight
        ).isActive = true
        self.isEnabled = true
        self.textColor = .dotori(.neutral(.n10))
        self.layer.borderWidth = 0
        self.layer.borderColor = nil
    }

    func setPlaceholderTextColor() {
        let placeholderTextColor = UIColor.dotori(.neutral(.n30))

        guard let placeholder else { return }
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: placeholderTextColor
            ]
        )
    }

    func textAreaEdges() -> UIEdgeInsets {
        UIEdgeInsets(
            top: 0,
            left: (
                DotoriTextFieldProperty.Dimension.leftMargin
                + self.iconViweWidth
                + DotoriTextFieldProperty.Dimension.subviewSpacing
            ),
            bottom: 0,
            right: (
                DotoriTextFieldProperty.Dimension.rightMargin
                + self.cleanrButtonWidth
                + DotoriTextFieldProperty.Dimension.subviewSpacing
            )
        )
    }
}
