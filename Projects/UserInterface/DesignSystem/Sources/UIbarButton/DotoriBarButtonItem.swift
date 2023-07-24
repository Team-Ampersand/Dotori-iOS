import UIKit

public final class DotoriBarButtonItem: UIBarButtonItem {
    public override init() {
        super.init()
        self.title = "DOTORI"
        self.isEnabled = false
        self.setTitleTextAttributes([
            .font: UIFont.dotori(.h3),
            .foregroundColor: UIColor.dotori(.primary(.p10))
        ], for: .disabled)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
