import NoticeDomainInterface

final class NoticeRepositorySpy: NoticeRepository {
    var fetchNoticeListCallCount = 0
    var fetchNoticeListReturn: [NoticeEntity] = []
    func fetchNoticeList() async throws -> [NoticeEntity] {
        fetchNoticeListCallCount += 1
        return fetchNoticeListReturn
    }
}
