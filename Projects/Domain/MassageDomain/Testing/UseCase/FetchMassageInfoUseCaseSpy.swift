import MassageDomainInterface

final class FetchMassageInfoUseCaseSpy: FetchMassageInfoUseCase {
    var fetchMassageInfoCallCount = 0
    var fetchMassageInfoReturn: MassageInfoEntity = .init(count: 0, limit: 0, massageStatus: .can)
    func callAsFunction() async throws -> MassageInfoEntity {
        fetchMassageInfoCallCount += 1
        return fetchMassageInfoReturn
    }
}
