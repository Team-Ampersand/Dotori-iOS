public protocol MusicRepository {
    func fetchMusicList() async throws -> [MusicEntity]
}
