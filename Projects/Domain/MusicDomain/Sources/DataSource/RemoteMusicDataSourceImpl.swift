import MusicDomainInterface
import NetworkingInterface

final class RemoteMusicDataSourceImpl: RemoteMusicDataSource {
    private let networking: any Networking

    init(networking: any Networking) {
        self.networking = networking
    }

    func fetchMusicList(date: String) async throws -> [MusicEntity] {
        try await networking.request(
            MusicEndpoint.fetchMusicList(date: date),
            dto: FetchMusicListResponseDTO.self
        )
        .toDomain()
    }

    func removeMusic(musicID: Int) async throws {
        try await networking.request(MusicEndpoint.removeMusic(musicID: musicID))
    }

    func proposeMusic(url: String) async throws {
        try await networking.request(MusicEndpoint.proposeMusic(url: url))
    }
}
