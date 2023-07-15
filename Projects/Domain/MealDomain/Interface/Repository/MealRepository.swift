import Foundation

public protocol MealRepository {
    func fetchMealInfo(date: Date) async throws -> [MealInfoEntity]
}
