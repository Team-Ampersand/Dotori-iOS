import UserDomainInterface

struct FetchProfileImageUseCaseImpl: FetchProfileImageUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func callAsFunction() async throws -> String {
        try await userRepository.fetchProfileImage()
    }
}
