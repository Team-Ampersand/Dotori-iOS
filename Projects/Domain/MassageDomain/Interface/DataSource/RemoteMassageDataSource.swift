public protocol RemoteMassageDataSource {
    func fetchMassageInfo() async throws -> MassageInfoEntity
    func applyMassage() async throws
}
