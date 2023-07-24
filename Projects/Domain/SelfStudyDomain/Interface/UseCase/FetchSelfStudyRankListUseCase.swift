public protocol FetchSelfStudyRankListUseCase {
    func callAsFunction(req: FetchSelfStudyRankSearchRequestDTO?) async throws -> [SelfStudyRankModel]
}

public extension FetchSelfStudyRankListUseCase {
    func callAsFunction(
        req: FetchSelfStudyRankSearchRequestDTO? = nil
    ) async throws -> [SelfStudyRankModel] {
        try await self.callAsFunction(req: req)
    }
}
