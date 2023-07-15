import Foundation

public protocol FetchMealInfoUseCase {
    func callAsFunction(date: Date) async throws -> [MealInfoModel]
}
