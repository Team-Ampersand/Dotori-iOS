import Foundation
import MealDomainInterface

final class RemoteMealDataSourceSpy: RemoteMealDataSource {
    var fetchMealInfoCallCount = 0
    var fetchMealInfoReturn: [MealInfoEntity] = []
    func fetchMealInfo(date: Date) async throws -> [MealInfoEntity] {
        fetchMealInfoCallCount += 1
        return fetchMealInfoReturn
    }
}
