import NoticeDomainInterface

final class NoticeRepositoryImpl: NoticeRepository {
    private let remoteNoticeDataSource: any RemoteNoticeDataSource

    init(remoteNoticeDataSource: any RemoteNoticeDataSource) {
        self.remoteNoticeDataSource = remoteNoticeDataSource
    }

    func fetchNoticeList() async throws -> [NoticeEntity] {
        try await remoteNoticeDataSource.fetchNoticeList()
    }

    func fetchNotice(id: Int) async throws -> DetailNoticeEntity {
        try await remoteNoticeDataSource.fetchNotice(id: id)
    }
}
