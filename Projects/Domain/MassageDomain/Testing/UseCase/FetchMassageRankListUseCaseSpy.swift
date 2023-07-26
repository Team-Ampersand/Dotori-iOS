import MassageDomainInterface

final class FetchMassageRankListUseCaseSpy: FetchMassageRankListUseCase {
    var fetchMassageRankListCallCount = 0
    var fetchMassageRankListHandler: () async throws -> [MassageRankEntity] = { [] }
    func callAsFunction() async throws -> [MassageRankModel] {
        fetchMassageRankListCallCount += 1
        return try await fetchMassageRankListHandler()
    }
}
