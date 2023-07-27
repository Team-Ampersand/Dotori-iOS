public protocol MusicRepository {
    func fetchMusicList(date: String) async throws -> [MusicEntity]
    func removeMusic(musicID: Int) async throws
}
