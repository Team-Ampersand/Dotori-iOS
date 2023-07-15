import Combine
import CombineMiniature
import Foundation
import MealDomainInterface

final class FetchMealInfoUseCaseSpy: FetchMealInfoUseCase {
    var fetchMealInfoCallCount = 0
    var fetchMealInfoReturn: [MealInfoEntity] = []
    func callAsFunction(date: Date) -> CombineMiniature<[MealInfoModel]> {
        fetchMealInfoCallCount += 1
        return CombineMiniature {
            nil
        } onRemote: {
            Just(self.fetchMealInfoReturn)
                .delay(for: 1, scheduler: RunLoop.current)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } refreshLocal: { _ in }
    }
}
