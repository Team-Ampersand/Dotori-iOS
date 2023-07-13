public protocol SelfStudyRepository {
    func fetchSelfStudyInfo() async throws -> SelfStudyInfoEntity
}
