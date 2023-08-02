import UserDomainInterface

struct WithdrawalUseCaseImpl: WithdrawalUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func callAsFunction() async throws {
        try await userRepository.withdrawal()
    }
}
