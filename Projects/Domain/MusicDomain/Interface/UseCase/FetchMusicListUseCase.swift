public protocol FetchMusicListUseCase {
    func callAsFunction(date: String) async throws -> [MusicModel]
}
