public protocol RemoteSelfStudyDataSource {
    func fetchSelfStudyInfo() async throws -> SelfStudyInfoEntity
}
