public protocol MassageRepository {
    func fetchMassageInfo() async throws -> MassageInfoEntity
    func applyMassage() async throws
}
