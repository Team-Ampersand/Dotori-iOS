public protocol SelfStudyRepository {
    func fetchSelfStudyInfo() async throws -> SelfStudyInfoEntity
    func applySelfStudy() async throws
    func fetchSelfStudyRankList() async throws -> [SelfStudyRankModel]
}
