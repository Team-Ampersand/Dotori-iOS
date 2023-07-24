import NoticeDomainInterface

final class RemoteNoticeDataSourceSpy: RemoteNoticeDataSource {
    var fetchNoticeListCallCount = 0
    var fetchNoticeListReturn: [NoticeEntity] = []
    func fetchNoticeList() async throws -> [NoticeEntity] {
        fetchNoticeListCallCount += 1
        return fetchNoticeListReturn
    }
}
