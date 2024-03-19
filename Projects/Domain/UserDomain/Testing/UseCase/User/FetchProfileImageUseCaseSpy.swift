import UserDomainInterface

final class FetchProfileImageUseCaseSpy: FetchProfileImageUseCase {
    var fetchUserInfoCallCount = 0
    var profileImage: String = ""
    func callAsFunction() -> String {
        fetchUserInfoCallCount += 1
        return profileImage
    }
}
