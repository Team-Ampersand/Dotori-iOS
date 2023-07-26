public protocol FetchMusicListUseCase {
    func callAsFunction() async throws -> [MusicModel]
}
