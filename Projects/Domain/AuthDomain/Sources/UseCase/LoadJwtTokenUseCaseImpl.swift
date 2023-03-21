import AuthDomainInterface
import Combine

struct LoadJwtTokenUseCaseImpl: LoadJwtTokenUseCase {
    private let authRepository: any AuthRepository

    func execute() -> AnyPublisher<JwtTokenEntity, Never> {
        authRepository.loadJwtToken()
    }
}
