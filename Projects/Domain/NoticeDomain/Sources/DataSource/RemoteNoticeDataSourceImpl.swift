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
        .toEntity()
    }
}
