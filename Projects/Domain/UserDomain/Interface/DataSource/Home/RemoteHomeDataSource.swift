public protocol RemoteHomeDataSource {
    func fetchProfileImage() async throws -> String
}
