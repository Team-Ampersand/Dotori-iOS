import MusicDomainInterface

struct ProposeMusicUseCaseImpl: ProposeMusicUseCase {
    private let musicRepository: any MusicRepository

    init(musicRepository: any MusicRepository) {
        self.musicRepository = musicRepository
    }

    func callAsFunction(url: String) async throws {
        try await musicRepository.proposeMusic(url: url)
    }
}
