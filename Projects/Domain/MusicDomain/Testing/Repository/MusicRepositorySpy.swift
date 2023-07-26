import MusicDomainInterface

final class MusicRepositorySpy: MusicRepository {
    var fetchMusicListCallCount = 0
    var fetchMusicListHandler: () async throws -> [MusicEntity] = { [] }
    func fetchMusicList() async throws -> [MusicEntity] {
        fetchMusicListCallCount += 1
        return try await fetchMusicListHandler()
    }
}
