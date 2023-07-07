import BaseFeature
import Combine
import CombineUtility
import Configure
import DesignSystem
import Localization
import MSGLayout
import UIKit

final class MealCardView: BaseView {
    private enum Metric {
        static let padding: CGFloat = 24
    }
    private let mealTitleLabel = DotoriLabel("급식")

    override func addView() {
        self.addSubviews {
            mealTitleLabel
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            mealTitleLabel.layout
                .top(.toSuperview(), .equal(24))
                .leading(.toSuperview(), .equal(24))
        }
    }

    override func configure() {
        self.backgroundColor = .dotori(.background(.card))
        self.layer.cornerRadius = 16
    }
}
