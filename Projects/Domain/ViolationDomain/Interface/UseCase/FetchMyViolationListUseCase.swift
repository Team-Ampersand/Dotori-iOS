public protocol FetchMyViolationListUseCase {
    func callAsFunction() async throws -> [ViolationModel]
}
