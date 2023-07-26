public protocol RemoteViolationDataSource {
    func fetchMyViolationList() async throws -> [ViolationEntity]
}
