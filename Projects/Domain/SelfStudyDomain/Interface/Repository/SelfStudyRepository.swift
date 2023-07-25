public protocol SelfStudyRepository {
    func fetchSelfStudyInfo() async throws -> SelfStudyInfoEntity
    func applySelfStudy() async throws
    func cancelSelfStudy() async throws
}
