public protocol RemoveMusicUseCase {
    func callAsFunction(musicID: Int) async throws
}
