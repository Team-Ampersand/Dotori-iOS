import Foundation
import MealDomainInterface
import AsyncNeiSwift
import NeiSwift

final class MealRepositoryImpl: MealRepository {
    private let remoteMealDataSource: any RemoteMealDataSource

    init(remoteMealDataSource: any RemoteMealDataSource) {
        self.remoteMealDataSource = remoteMealDataSource
    }

    func fetchMealInfo(date: Date) async throws -> [MealInfoEntity] {
        try await remoteMealDataSource.fetchMealInfo(date: date)
    }
}
