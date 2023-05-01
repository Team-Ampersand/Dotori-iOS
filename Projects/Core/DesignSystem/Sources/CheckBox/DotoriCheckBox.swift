import UIKit

public final class DotoriCheckBox: UIControl {

    private let checkedView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.image = UIImage.checkmark.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white
        return view
    }()
    
    private var hitRadiusOffset: CGFloat = 10

    private var checkedViewInsets: UIEdgeInsets = UIEdgeInsets(
        top: 5,
        left: 5,
        bottom: 5,
        right: 5
    ) {
        didSet {
            layoutIfNeeded()
        }
    }

    public var isChecked: Bool = false {
        didSet {
            updateState()
        }
    }

    public var checkedBackgroundColor: UIColor = .dotori(.primary(.p10)) {
        didSet {
            backgroundColor = isChecked ? checkedBackgroundColor : uncheckedBackgroundColor
        }
    }

    public var uncheckedBackgroundColor: UIColor = .white {
        didSet {
            backgroundColor = isChecked ? checkedBackgroundColor : uncheckedBackgroundColor
        }
    }

    public var checkedImage: UIImage? = UIImage.checkmark {
        didSet {
            checkedView.image = checkedImage?.withRenderingMode(.alwaysTemplate)
        }
    }

    public var checkedBorderColor: UIColor = .dotori(.primary(.p10)) {
        didSet {
            layer.borderColor = isChecked ? checkedBorderColor.cgColor : uncheckedBorderColor.cgColor
        }
    }

    public var uncheckedBorderColor: UIColor = .dotori(.neutral(.n30)) {
        didSet {
            layer.borderColor = isChecked ? checkedBorderColor.cgColor : uncheckedBorderColor.cgColor
        }
    }

    public var imageTint: UIColor? = .white {
        didSet {
            checkedView.tintColor = imageTint
        }
    }

    public init(isChecked: Bool) {
        self.isChecked = isChecked
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    //MARK: - handle touches
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        sendActions(for: .valueChanged)
        isChecked.toggle()
    }

    //MARK: - Increase hit area
    public override func point(
        inside point: CGPoint,
        with event: UIEvent?
    ) -> Bool {
        return bounds.inset(by: UIEdgeInsets(
            top: -hitRadiusOffset,
            left: -hitRadiusOffset,
            bottom: -hitRadiusOffset,
            right: -hitRadiusOffset)
        ).contains(point)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        checkedView.frame = CGRect(
            x: checkedViewInsets.left,
            y: checkedViewInsets.top,
            width: frame.width - checkedViewInsets.left - checkedViewInsets.right,
            height: frame.height - checkedViewInsets.top - checkedViewInsets.bottom
        )
    }
    
}

private extension DotoriCheckBox {
    private func setup() {
        backgroundColor = uncheckedBackgroundColor
        layer.borderColor = uncheckedBorderColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        addSubview(checkedView)
    }

    private func updateState() {
        backgroundColor = isChecked ? checkedBackgroundColor : uncheckedBackgroundColor
        layer.borderColor = isChecked ? checkedBorderColor.cgColor : uncheckedBorderColor.cgColor
        checkedView.isHidden = !isChecked
    }
}
