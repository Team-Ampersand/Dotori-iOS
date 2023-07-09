import Foundation
import Localization

enum MealPartTime: CaseIterable {
    case breakfast
    case lunch
    case dinner
}

extension MealPartTime {
    var display: String {
        switch self {
        case .breakfast:
            return L10n.Home.breakfast

        case .lunch:
            return L10n.Home.lunch

        case .dinner:
            return L10n.Home.dinner
        }
    }
}
