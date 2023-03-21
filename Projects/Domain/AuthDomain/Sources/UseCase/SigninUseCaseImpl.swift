import AuthDomainInterface
import Combine

struct SigninUseCaseImpl: SigninUseCase {
    private let authRepository: any AuthRepository

    func execute(req: SigninRequestDTO) -> AnyPublisher<Void, AuthDomainError> {
        authRepository.signin(req: req)
    }
}
