public protocol MassageRepository {
    func fetchMassageInfo() async throws -> MassageInfoEntity
}
