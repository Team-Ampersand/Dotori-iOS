import UserDomainInterface

final class FetchProfileImageUseCaseSpy: FetchProfileImageUseCase {
    var fetchProfileImageCallCount = 0
    var fetchProfileImageHandler: () async throws -> String = { "" }
    func callAsFunction() async throws -> String {
        fetchProfileImageCallCount += 1
        return try await fetchProfileImageHandler()
    }
}
