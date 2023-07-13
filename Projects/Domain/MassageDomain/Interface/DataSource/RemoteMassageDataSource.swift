public protocol RemoteMassageDataSource {
    func fetchMassageInfo() async throws -> MassageInfoEntity
}
