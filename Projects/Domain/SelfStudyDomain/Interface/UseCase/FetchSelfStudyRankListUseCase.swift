public protocol FetchSelfStudyRankListUseCase {
    func callAsFunction() async throws -> [SelfStudyRankModel]
}
