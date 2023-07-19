public protocol FetchMassageInfoUseCase {
    func callAsFunction() async throws -> MassageInfoModel
}
