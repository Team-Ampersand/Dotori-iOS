import MusicDomainInterface

struct FetchMusicListUseCaseImpl: FetchMusicListUseCase {
    private let musicRepository: any MusicRepository

    init(musicRepository: any MusicRepository) {
        self.musicRepository = musicRepository
    }

    func callAsFunction() async throws -> [MusicModel] {
        try await musicRepository.fetchMusicList()
    }
}
