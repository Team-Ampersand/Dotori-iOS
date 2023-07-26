public protocol FetchMassageRankListUseCase {
    func callAsFunction() async throws -> [MassageRankModel]
}
