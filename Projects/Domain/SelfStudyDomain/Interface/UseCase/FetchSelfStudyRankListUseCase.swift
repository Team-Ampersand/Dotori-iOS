public protocol FetchSelfStudyRankListUseCase {
    func callAsFunction(req: FetchSelfStudyRankSearchRequestDTO?) async throws -> [SelfStudyRankModel]
}
