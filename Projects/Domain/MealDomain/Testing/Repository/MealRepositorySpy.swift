import Combine
import CombineMiniature
import Foundation
import MealDomainInterface

final class MealRepositorySpy: MealRepository {
    var fetchMealInfoCallCount = 0
    var fetchMealInfoReturn: [MealInfoEntity] = []
    func fetchMealInfo(date: Date) -> CombineMiniature<[MealInfoEntity]> {
        fetchMealInfoCallCount += 1
        return CombineMiniature {
            nil
        } onRemote: {
            Just(self.fetchMealInfoReturn)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } refreshLocal: { _ in }
    }
}
