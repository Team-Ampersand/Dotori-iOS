import NoticeDomainInterface

final class FetchNoticeListUseCaseSpy: FetchNoticeListUseCase {
    var fetchNoticeListCallCount = 0
    var fetchNoticeListReturn: [NoticeModel] = []
    func callAsFunction() async throws -> [NoticeModel] {
        fetchNoticeListCallCount += 1
        return fetchNoticeListReturn
    }
}
