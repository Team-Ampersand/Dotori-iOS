import DesignSystem
import UIKit

final class MealPartTimeSegmentedControl: UISegmentedControl {
    init(items: [Any]) {
        super.init(items: items)
        configureFont()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MealPartTimeSegmentedControl {
    func configureFont() {
        let normalAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.dotori(.subtitle2),
            .foregroundColor: UIColor.dotori(.neutral(.n30))
        ]
        self.setTitleTextAttributes(normalAttribute, for: .normal)

        let selectedAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.dotori(.subtitle2),
            .foregroundColor: UIColor.dotori(.neutral(.n10))
        ]
        self.setTitleTextAttributes(selectedAttribute, for: .selected)
    }
}
