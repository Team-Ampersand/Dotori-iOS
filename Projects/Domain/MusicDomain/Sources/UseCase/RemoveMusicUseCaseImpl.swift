import MusicDomainInterface

struct RemoveMusicUseCaseImpl: RemoveMusicUseCase {
    private let musicRepository: any MusicRepository

    init(musicRepository: any MusicRepository) {
        self.musicRepository = musicRepository
    }

    func callAsFunction(musicID: Int) async throws {
        try await musicRepository.removeMusic(musicID: musicID)
    }
}
