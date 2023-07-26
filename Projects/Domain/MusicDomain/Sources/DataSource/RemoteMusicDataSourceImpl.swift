import MusicDomainInterface
import NetworkingInterface

final class RemoteMusicDataSourceImpl: RemoteMusicDataSource {
    private let networking: any Networking

    init(networking: any Networking) {
        self.networking = networking
    }

    func fetchMusicList() async throws -> [MusicEntity] {
        try await networking.request(
            MusicEndpoint.fetchMusicList,
            dto: FetchMusicListResponseDTO.self
        )
        .toDomain()
    }
}
