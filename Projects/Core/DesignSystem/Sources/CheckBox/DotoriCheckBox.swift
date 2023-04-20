import Then
import UIKit

public final class DotoriCheckBox: UIControl {

    private let checkedView = UIImageView().then {
        $0.image = UIImage.checkmark.withRenderingMode(.alwaysTemplate)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        $0.tintColor = .dotori(.sub(.white))
    }

    private var isChecked: Bool = false {
        didSet {
            updateState()
        }
    }

    private var hitRadiusOffset: CGFloat = 10

    private var checkedViewInsets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) {
        didSet {
            layoutIfNeeded()
        }
    }

    private var checkedBackgroundColor: UIColor = .dotori(.primary(.p10)) {
        didSet {
            backgroundColor = isChecked ? checkedBackgroundColor : uncheckedBackgroundColor
        }
    }

    private var uncheckedBackgroundColor: UIColor = .white {
        didSet {
            backgroundColor = isChecked ? checkedBackgroundColor : uncheckedBackgroundColor
        }
    }

    private var checkedImage: UIImage? = UIImage.checkmark {
        didSet {
            checkedView.image = checkedImage?.withRenderingMode(.alwaysTemplate)
        }
    }

    private var checkedBorderColor: UIColor = .dotori(.primary(.p10)) {
        didSet {
            layer.borderColor = isChecked ? checkedBorderColor.cgColor : uncheckedBorderColor.cgColor
        }
    }

    private var uncheckedBorderColor: UIColor = .dotori(.neutral(.n30)) {
        didSet {
            layer.borderColor = isChecked ? checkedBorderColor.cgColor : uncheckedBorderColor.cgColor
        }
    }

    private var imageTint: UIColor? = .white {
        didSet {
            checkedView.tintColor = imageTint
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        self.backgroundColor = uncheckedBackgroundColor
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

    //MARK: - handle touches
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        sendActions(for: .valueChanged)
        isChecked.toggle()
    }

    //MARK: - Increase hit area
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.inset(by: UIEdgeInsets(top: -hitRadiusOffset, left: -hitRadiusOffset, bottom: -hitRadiusOffset, right: -hitRadiusOffset)).contains(point)
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
