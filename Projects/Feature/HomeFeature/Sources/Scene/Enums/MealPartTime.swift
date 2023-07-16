import Foundation
import Localization
import MealDomainInterface

enum MealPartTime: Int, CaseIterable {
    case breakfast = 0
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

    var toMealType: MealType {
        switch self {
        case .breakfast: return .breakfast
        case .lunch: return .lunch
        case .dinner: return .dinner
        }
    }
}
