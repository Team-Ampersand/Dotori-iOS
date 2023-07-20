import UIKit

public final class DotoriBarButtonItem: UIBarButtonItem {
    public convenience override init() {
        self.init(title: "DOTORI", style: .done, target: nil, action: nil)
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
