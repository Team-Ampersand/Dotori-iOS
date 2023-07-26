public protocol MusicRepository {
    func fetchMusicList(date: String) async throws -> [MusicEntity]
}
