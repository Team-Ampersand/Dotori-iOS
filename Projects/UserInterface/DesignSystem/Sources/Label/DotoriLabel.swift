import UIKit

public final class DotoriLabel: UILabel {
    public init(
        _ title: String,
        font: UIFont.DotoriFontSystem = .subtitle2,
        textColor: UIColor.DotoriColorSystem = .neutral(.n10)
    ) {
        super.init(frame: .zero)
        self.text = title
        self.font = .dotori(font)
        self.textColor = .dotori(textColor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
