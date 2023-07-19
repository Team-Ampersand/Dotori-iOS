import Foundation

public protocol RemoteMealDataSource {
    func fetchMealInfo(date: Date) async throws -> [MealInfoEntity]
}
