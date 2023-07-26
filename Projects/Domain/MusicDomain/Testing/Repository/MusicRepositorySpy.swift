import MusicDomainInterface

final class MusicRepositorySpy: MusicRepository {
    var fetchMusicListCallCount = 0
    var fetchMusicListHandler: (String) async throws -> [MusicEntity] = { _ in [] }
    func fetchMusicList(date: String) async throws -> [MusicEntity] {
        fetchMusicListCallCount += 1
        return try await fetchMusicListHandler(date)
    }
}
