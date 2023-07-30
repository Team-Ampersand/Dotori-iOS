public protocol RemoteMassageDataSource {
    func fetchMassageInfo() async throws -> MassageInfoEntity
    func applyMassage() async throws
    func cancelMassage() async throws
    func fetchMassageRankList() async throws -> [MassageRankEntity]
    func modifyMassagePersonnel(limit: Int) async throws
}
