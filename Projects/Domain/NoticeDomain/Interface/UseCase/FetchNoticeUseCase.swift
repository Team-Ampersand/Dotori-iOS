public protocol FetchNoticeUseCase {
    func callAsFunction(id: Int) async throws -> DetailNoticeModel
}
