import NoticeDomainInterface

final class NoticeRepositoryImpl: NoticeRepository {
    private let remoteNoticeDataSource: any RemoteNoticeDataSource

    init(remoteNoticeDataSource: any RemoteNoticeDataSource) {
        self.remoteNoticeDataSource = remoteNoticeDataSource
    }

    func fetchNoticeList() async throws -> [NoticeEntity] {
        try await remoteNoticeDataSource.fetchNoticeList()
    }
}
