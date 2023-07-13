public protocol FetchSelfStudyInfoUseCase {
    func callAsFunction() async throws -> SelfStudyInfoModel
}
