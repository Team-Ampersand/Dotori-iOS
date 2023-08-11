import MSGLayout
import UIKit

public final class DotoriLabel: UILabel {
    public var padding = UIEdgeInsets.all(0)

    override public var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }

    public init(
        _ title: String = "",
        textColor: UIColor.DotoriColorSystem = .neutral(.n10),
        font: UIFont.DotoriFontSystem = .subtitle2
    ) {
        super.init(frame: .zero)
        self.text = title
        self.font = .dotori(font)
        self.textColor = .dotori(textColor)
    }

    override public func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
