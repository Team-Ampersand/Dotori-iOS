import AuthDomainInterface
import Combine

struct LoadJwtTokenUseCaseImpl: LoadJwtTokenUseCase {
    private let authRepository: any AuthRepository

    init(authRepository: any AuthRepository) {
        self.authRepository = authRepository
    }

    func execute() -> AnyPublisher<JwtTokenEntity, Never> {
        authRepository.loadJwtToken()
    }
}
