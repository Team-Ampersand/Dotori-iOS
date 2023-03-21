import Combine

public protocol SigninUseCase {
    func execute(req: SigninRequestDTO) -> AnyPublisher<Void, AuthDomainError>
}
