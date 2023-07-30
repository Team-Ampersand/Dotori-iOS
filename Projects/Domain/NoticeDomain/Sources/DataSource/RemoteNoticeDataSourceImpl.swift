import NetworkingInterface
import NoticeDomainInterface

final class RemoteNoticeDataSourceImpl: RemoteNoticeDataSource {
    private let networking: any Networking

    init(networking: any Networking) {
        self.networking = networking
    }

    func fetchNoticeList() async throws -> [NoticeEntity] {
        try await networking.request(
            NoticeEndpoint.fetchNoticeList,
            dto: FetchNoticeListResponseDTO.self
        )
        .toDomain()
    }

    func fetchNotice(id: Int) async throws -> DetailNoticeEntity {
        try await networking.request(
            NoticeEndpoint.fetchNotice(id: id),
            dto: FetchNoticeResponseDTO.self
        )
        .toDomain()
    }

    func removeNotice(id: Int) async throws {
        try await networking.request(NoticeEndpoint.removeNotice(id: id))
    }
}
