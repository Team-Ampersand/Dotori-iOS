import NetworkingInterface
import UserDomainInterface

final class RemoteHomeDataSourceImpl: RemoteHomeDataSource {
    private let networking: any Networking

    init(networking: any Networking) {
        self.networking = networking
    }

    func fetchProfileImage() async throws -> String {
        try await networking.request(
            HomeEndpoint.fetchProfileImage,
            dto: FetchProfileImageResponseDTO.self
        )
        .toDomain()
    }
}
