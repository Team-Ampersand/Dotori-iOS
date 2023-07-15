import Foundation
import MealDomainInterface

final class FetchMealInfoUseCaseSpy: FetchMealInfoUseCase {
    var fetchMealInfoCallCount = 0
    var fetchMealInfoReturn: [MealInfoEntity] = []
    func callAsFunction(date: Date) async throws -> [MealInfoModel] {
        fetchMealInfoCallCount += 1
        return fetchMealInfoReturn
    }
}
