import Combine
import CombineUtility
import Configure
import GlobalThirdPartyLibrary
import UIKit

public protocol DotoriCheckBoxActionProtocol {
    var checkBoxDidTapPublisher: AnyPublisher<Bool, Never> { get }
}

public final class DotoriCheckBox: UIControl {
    private let checkedView = UIImageView()
        .set(\.translatesAutoresizingMaskIntoConstraints, false)
        .set(\.image, .Dotori.checkMark.withRenderingMode(.alwaysTemplate))
        .set(\.tintColor, .white)
    private var checkedBackgroundColor: UIColor = .dotori(.primary(.p10))
    private var uncheckedBackgroundColor: UIColor = .clear
    private var checkedBorderColor: UIColor = .dotori(.primary(.p10))
    private var uncheckedBorderColor: UIColor = .dotori(.neutral(.n30))
    private var hitRadiusOffset: CGFloat = 10
    private var checkedViewInsets: UIEdgeInsets = UIEdgeInsets(
        top: 8,
        left: 7,
        bottom: 8,
        right: 7
    )

    public var isChecked: Bool = false {
        didSet {
            updateState()
        }
    }

    public init(isChecked: Bool = false) {
        self.isChecked = isChecked
        super.init(frame: .zero)
        checkedView.isHidden = !isChecked
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - handle touches
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.isChecked.toggle()
        sendActions(for: .valueChanged)
    }

    // MARK: - Increase hit area
    override public func point(
        inside point: CGPoint,
        with event: UIEvent?
    ) -> Bool {
        let insets = UIEdgeInsets(
            top: -hitRadiusOffset,
            left: -hitRadiusOffset,
            bottom: -hitRadiusOffset,
            right: -hitRadiusOffset
        )
        return bounds.inset(by: insets).contains(point)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        checkedView.frame = CGRect(
            x: checkedViewInsets.left,
            y: checkedViewInsets.top,
            width: frame.width - checkedViewInsets.left - checkedViewInsets.right,
            height: frame.height - checkedViewInsets.top - checkedViewInsets.bottom
        )
    }
}

extension DotoriCheckBox: DotoriCheckBoxActionProtocol {
    public var checkBoxDidTapPublisher: AnyPublisher<Bool, Never> {
        self.controlPublisher(for: .valueChanged)
            .compactMap { $0 as? DotoriCheckBox }
            .map(\.isChecked)
            .eraseToAnyPublisher()
    }
}

private extension DotoriCheckBox {
    func setup() {
        backgroundColor = uncheckedBackgroundColor
        layer.borderColor = uncheckedBorderColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        addSubview(checkedView)
    }

    func updateState() {
        backgroundColor = isChecked ? checkedBackgroundColor : uncheckedBackgroundColor
        layer.borderColor = isChecked ? checkedBorderColor.cgColor : uncheckedBorderColor.cgColor
        checkedView.isHidden = !isChecked
    }
}
