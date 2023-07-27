import MusicDomainInterface

final class RemoveMusicUseCaseSpy: RemoveMusicUseCase {
    var removeMusicCallCount = 0
    func callAsFunction(musicID: Int) async throws {
        removeMusicCallCount += 1
    }
}
