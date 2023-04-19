import UIKit

public final class DotoriToggle: UISwitch {
    public init() {
        super.init(frame: .zero)
        onTintColor = .dotori(.primary(.p10))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
