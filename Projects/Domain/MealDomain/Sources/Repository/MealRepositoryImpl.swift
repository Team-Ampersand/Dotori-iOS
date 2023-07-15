import Combine
import CombineMiniature
import Foundation
import MealDomainInterface

final class MealRepositoryImpl: MealRepository {
    private let remoteMealDataSource: any RemoteMealDataSource
    private let localMealDataSource: any LocalMealDataSource

    init(
        remoteMealDataSource: any RemoteMealDataSource,
        localMealDataSource: any LocalMealDataSource
    ) {
        self.remoteMealDataSource = remoteMealDataSource
        self.localMealDataSource = localMealDataSource
    }

    func fetchMealInfo(date: Date) -> CombineMiniature<[MealInfoEntity]> {
        CombineMiniature { [localMealDataSource] in
            try? localMealDataSource.loadMealInfo(date: date)
        } onRemote: { [onRemotePublisher] in
            onRemotePublisher(date)
        } refreshLocal: { [localMealDataSource] newValue in
            try? localMealDataSource.deleteMealInfoByNotNearToday()
            try? localMealDataSource.saveMealInfoList(date: date, mealInfoList: newValue)
        }
    }
}

private extension MealRepositoryImpl {
    func onRemotePublisher(date: Date) -> AnyPublisher<[MealInfoEntity], Error> {
        Deferred {
            let subject = PassthroughSubject<[MealInfoEntity], Error>()
            let task = Task { @MainActor in
                do {
                    try Task.checkCancellation()
                    let output = try await self.remoteMealDataSource.fetchMealInfo(date: date)
                    try Task.checkCancellation()
                    subject.send(output)
                    subject.send(completion: .finished)
                } catch is CancellationError {
                    subject.send(completion: .finished)
                } catch {
                    subject.send(completion: .failure(error))
                }
            }
            
            return subject.handleEvents(receiveCancel: task.cancel)
        }
        .eraseToAnyPublisher()
    }
}
