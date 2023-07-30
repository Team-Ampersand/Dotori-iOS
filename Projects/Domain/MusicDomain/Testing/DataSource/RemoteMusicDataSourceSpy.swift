import MusicDomainInterface

final class RemoteMusicDataSourceSpy: RemoteMusicDataSource {
    var fetchMusicListCallCount = 0
    var fetchMusicListHandler: (String) async throws -> [MusicEntity] = { _ in [] }
    func fetchMusicList(date: String) async throws -> [MusicEntity] {
        fetchMusicListCallCount += 1
        return try await fetchMusicListHandler(date)
    }

    var removeMusicCallCount = 0
    func removeMusic(musicID: Int) async throws {
        removeMusicCallCount += 1
    }

    var proposeMusicCallCount = 0
    func proposeMusic(url: String) async throws {
        proposeMusicCallCount += 1
    }
}
