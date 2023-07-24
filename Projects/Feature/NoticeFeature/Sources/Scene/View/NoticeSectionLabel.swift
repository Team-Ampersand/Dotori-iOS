import BaseFeature
import Configure
import DesignSystem
import MSGLayout
import UIKit

final class NoticeSectionLabel:
    UIView,
    AddViewable,
    SetLayoutable {
    private let leftLine = UIView()
        .set(\.backgroundColor, .dotori(.neutral(.n40)))
    private let titleLabel = DotoriLabel(textColor: .neutral(.n20), font: .body2)
    private let rightLine = UIView()
        .set(\.backgroundColor, .dotori(.neutral(.n40)))

    init(title: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        addView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addView() {
        self.addSubviews {
            leftLine
            titleLabel
            rightLine
        }
    }

    func setLayout() {
        MSGLayout.buildLayout {
            leftLine.layout
                .height(1)
                .centerY(.to(titleLabel))
                .trailing(.to(titleLabel).leading, .equal(-8))
                .leading(.toSuperview(), .equal(16))

            titleLabel.layout
                .center(.toSuperview())

            rightLine.layout
                .height(1)
                .centerY(.to(titleLabel))
                .leading(.to(titleLabel).trailing, .equal(8))
                .trailing(.toSuperview(), .equal(-16))
        }
    }
}
