import SelfStudyDomainInterface

final class FetchSelfStudyRankListUseCaseSpy: FetchSelfStudyRankListUseCase {
    var fetchSelfStudyRankListCallCount = 0
    var fetchSelfStudyRankListReturn: [SelfStudyRankModel] = []
    func callAsFunction(req: FetchSelfStudyRankSearchRequestDTO?) async throws -> [SelfStudyRankModel] {
        fetchSelfStudyRankListCallCount += 1
        return fetchSelfStudyRankListReturn
    }
}
