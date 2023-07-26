public protocol RemoteMusicDataSource {
    func fetchMusicList() async throws -> [MusicEntity]
}
