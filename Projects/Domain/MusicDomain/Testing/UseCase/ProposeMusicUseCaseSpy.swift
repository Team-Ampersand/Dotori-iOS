import MusicDomainInterface

final class ProposeMusicUseCaseSpy: ProposeMusicUseCase {
    var proposeMusicCallCount = 0
    func callAsFunction(url: String) async throws {
        proposeMusicCallCount += 1
    }
}
