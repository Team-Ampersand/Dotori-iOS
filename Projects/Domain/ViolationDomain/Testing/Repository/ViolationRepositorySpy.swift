import ViolationDomainInterface

final class ViolationRepositorySpy: ViolationRepository {
    var fetchMyViolationListCallCount = 0
    var fetchMyViolationListHandler: () throws -> [ViolationEntity] = { [] }
    func fetchMyViolationList() async throws -> [ViolationEntity] {
        fetchMyViolationListCallCount += 1
        return try fetchMyViolationListHandler()
    }
}
