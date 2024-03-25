import UserDomainInterface

struct LogoutUseCaseImpl: LogoutUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func callAsFunction() {
        userRepository.logout()
    }
}
