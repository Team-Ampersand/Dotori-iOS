public protocol RemoteSelfStudyDataSource {
    func fetchSelfStudyInfo() async throws -> SelfStudyInfoEntity
    func applySelfStudy() async throws
    func cancelSelfStudy() async throws
    func fetchSelfStudyRankList() async throws -> [SelfStudyRankEntity]
    func fetchSelfStudyRankSearch(req: FetchSelfStudyRankSearchRequestDTO) async throws -> [SelfStudyRankEntity]
    func checkSelfStudyMember(memberID: Int, isChecked: Bool) async throws
    func modifySelfStudyPersonnel(limit: Int) async throws
}
