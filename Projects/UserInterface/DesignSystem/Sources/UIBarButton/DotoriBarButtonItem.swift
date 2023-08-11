import UIKit

public final class DotoriBarButtonItem: UIBarButtonItem {
    override public init() {
        super.init()
        self.title = "DOTORI"
        self.isEnabled = false
        self.setTitleTextAttributes([
            .font: UIFont.dotori(.h3),
            .foregroundColor: UIColor.dotori(.primary(.p10))
        ], for: .disabled)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
