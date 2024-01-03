import DesignSystem
import UIKit

final class MealContentStackView: UIStackView {
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .dotori(.neutral(.n50))
        self.cornerRadius = 16
        self.axis = .vertical
        self.layoutMargins = .all(24)
        self.distribution = .fillEqually
        self.isLayoutMarginsRelativeArrangement = true
        self.alignment = .leading
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func updateContent(meals: [String]) {
        self.removeAllChildren()
        var mealViews: [DotoriLabel] = []
        
        if meals.isEmpty {
            let emptyLabels = (1...6).map { _ in DotoriLabel("") }
            mealViews.append(DotoriLabel("급식이 없습니다."))
            mealViews.append(contentsOf: emptyLabels)
        } else {
            mealViews = meals.map { DotoriLabel($0) }
        }
        
        for (index, view) in mealViews.enumerated() {
            UIView.animate(withDuration: 0.5, delay: 0.05 * Double(index), options: [], animations: {
                view.alpha = 1.0
            }, completion: nil)
        }
    }
}
