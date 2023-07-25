import ViolationDomainInterface

final class RemoteViolationDataSourceSpy: RemoteViolationDataSource {
    var fetchMyViolationListCallCount = 0
    var fetchMyViolationListHandler: () async throws -> [ViolationEntity] = { [] }
    func fetchMyViolationList() async throws -> [ViolationEntity] {
        fetchMyViolationListCallCount += 1
        return try await fetchMyViolationListHandler()
    }
}
