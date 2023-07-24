public protocol FetchNoticeListUseCase {
    func callAsFunction() async throws -> [NoticeModel]
}
