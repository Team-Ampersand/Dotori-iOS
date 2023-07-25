import UIKit

public final class DotoriNavigationBarLabel: UIBarButtonItem {
    private let titleLabel = DotoriLabel(textColor: .neutral(.n10), font: .subtitle1)
    public init(text: String) {
        super.init()
        self.titleLabel.text = text
        self.customView = titleLabel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
