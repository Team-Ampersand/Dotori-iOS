public protocol SelfStudyRepository {
    func fetchSelfStudyInfo() async throws -> SelfStudyInfoEntity
    func applySelfStudy() async throws
    func fetchSelfStudyRankList() async throws -> [SelfStudyRankEntity]
    func fetchSelfStudyRankSearch(req: FetchSelfStudyRankSearchRequestDTO) async throws -> [SelfStudyRankEntity]
}
