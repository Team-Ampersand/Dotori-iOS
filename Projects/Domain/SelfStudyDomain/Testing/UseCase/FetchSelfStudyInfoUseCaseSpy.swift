import SelfStudyDomainInterface

public final class FetchSelfStudyInfoUseCaseSpy: FetchSelfStudyInfoUseCase {
    public var fetchSelfStudyInfoCallCount = 0
    public var fetchSelfStudyInfoReturn: SelfStudyInfoEntity = .init(count: 0, limit: 0, selfStudyStatus: .can)

    public func callAsFunction() async throws -> SelfStudyInfoEntity {
        fetchSelfStudyInfoCallCount += 1
        return fetchSelfStudyInfoReturn
    }
}
