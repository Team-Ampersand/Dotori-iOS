import MusicDomainInterface

final class FetchMusicListUseCaseSpy: FetchMusicListUseCase {
    var fetchMusicListCallCount = 0
    var fetchMusicListHandler: (String) async throws -> [MusicModel] = { _ in [] }
    func callAsFunction(date: String) async throws -> [MusicModel] {
        fetchMusicListCallCount += 1
        return try await fetchMusicListHandler(date)
    }
}
