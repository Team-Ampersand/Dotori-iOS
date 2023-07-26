public protocol RemoteMusicDataSource {
    func fetchMusicList(date: String) async throws -> [MusicEntity]
}
