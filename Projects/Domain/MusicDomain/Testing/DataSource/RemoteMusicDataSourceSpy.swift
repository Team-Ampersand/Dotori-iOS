import MusicDomainInterface

final class RemoteMusicDataSourceSpy: RemoteMusicDataSource {
    var fetchMusicListCallCount = 0
    var fetchMusicListHandler: () async throws -> [MusicEntity] = { [] }
    func fetchMusicList() async throws -> [MusicEntity] {
        fetchMusicListCallCount += 1
        return try await fetchMusicListHandler()
    }
}
