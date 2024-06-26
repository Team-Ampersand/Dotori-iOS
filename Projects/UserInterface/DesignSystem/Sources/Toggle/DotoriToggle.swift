import UIKit

public final class DotoriToggle: UISwitch {
    public init() {
        super.init(frame: .zero)
        self.onTintColor = .dotori(.primary(.p10))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
