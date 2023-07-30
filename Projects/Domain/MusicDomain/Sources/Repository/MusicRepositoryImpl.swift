import MusicDomainInterface

final class MusicRepositoryImpl: MusicRepository {
    private let remoteMusicDataSource: any RemoteMusicDataSource

    init(remoteMusicDataSource: any RemoteMusicDataSource) {
        self.remoteMusicDataSource = remoteMusicDataSource
    }

    func fetchMusicList(date: String) async throws -> [MusicEntity] {
        try await remoteMusicDataSource.fetchMusicList(date: date)
    }

    func removeMusic(musicID: Int) async throws {
        try await remoteMusicDataSource.removeMusic(musicID: musicID)
    }

    func proposeMusic(url: String) async throws {
        try await remoteMusicDataSource.proposeMusic(url: url)
    }
}
