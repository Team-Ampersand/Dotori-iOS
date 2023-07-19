import SelfStudyDomainInterface

final class FetchSelfStudyInfoUseCaseSpy: FetchSelfStudyInfoUseCase {
    var fetchSelfStudyInfoCallCount = 0
    var fetchSelfStudyInfoReturn: SelfStudyInfoEntity = .init(count: 0, limit: 0, selfStudyStatus: .can)

    func callAsFunction() async throws -> SelfStudyInfoEntity {
        fetchSelfStudyInfoCallCount += 1
        return fetchSelfStudyInfoReturn
    }
}
