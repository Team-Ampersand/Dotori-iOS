import MusicDomainInterface

final class FetchMusicListUseCaseSpy: FetchMusicListUseCase {
    var fetchMusicListCallCount = 0
    var fetchMusicListHandler: () async throws -> [MusicEntity] = { [] }
    func callAsFunction() async throws -> [MusicEntity] {
        fetchMusicListCallCount += 1
        return try await fetchMusicListHandler()
    }
}
