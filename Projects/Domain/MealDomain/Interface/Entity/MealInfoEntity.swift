import Foundation

public struct MealInfoEntity: Equatable {
    public let meals: [String]
    public let mealType: MealType

    public init(meals: [String], mealType: MealType) {
        self.meals = meals
        self.mealType = mealType
    }
}
