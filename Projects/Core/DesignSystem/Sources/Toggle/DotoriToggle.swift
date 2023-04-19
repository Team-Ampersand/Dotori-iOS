import UIKit

public final class DotoriToggle: UISwitch {
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        self.onTintColor = .dotori(.primary(.p10))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
