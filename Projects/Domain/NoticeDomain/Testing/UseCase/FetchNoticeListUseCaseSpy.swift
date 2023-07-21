import NoticeDomainInterface

final class FetchNoticeListUseCaseSpy: FetchNoticeListUseCase {
    var fetchNoticeListCallCount = 0
    var fetchNoticeListReturn: [NoticeEntity] = []
    func callAsFunction() async throws -> [NoticeEntity] {
        fetchNoticeListCallCount += 1
        return fetchNoticeListReturn
    }
}
