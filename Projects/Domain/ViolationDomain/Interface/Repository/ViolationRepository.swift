public protocol ViolationRepository {
    func fetchMyViolationList() async throws -> [ViolationEntity]
}
