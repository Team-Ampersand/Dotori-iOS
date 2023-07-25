import ViolationDomainInterface

final class FetchMyViolationListUseCaseSpy: FetchMyViolationListUseCase {
    var fetchMyViolationListCallCount = 0
    var fetchMyViolationListHandler: () throws -> [ViolationModel] = { [] }
    func callAsFunction() async throws -> [ViolationModel] {
        fetchMyViolationListCallCount += 1
        return try fetchMyViolationListHandler()
    }
}
