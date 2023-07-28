import BaseDomainInterface
import NoticeDomainInterface

final class RemoteNoticeDataSourceSpy: RemoteNoticeDataSource {
    var fetchNoticeListCallCount = 0
    var fetchNoticeListReturn: [NoticeEntity] = []
    func fetchNoticeList() async throws -> [NoticeEntity] {
        fetchNoticeListCallCount += 1
        return fetchNoticeListReturn
    }

    var fetchNoticeCallCount = 0
    var fetchNoticeHandler: (Int) async throws -> DetailNoticeEntity = { _ in
            .init(
                id: 1,
                title: "",
                content: "",
                role: .member,
                images: [],
                createdDate: .init()
            )
    }
    func fetchNotice(id: Int) async throws -> DetailNoticeEntity {
        fetchNoticeCallCount += 1
        return try await fetchNoticeHandler(id)
    }
}
