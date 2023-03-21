import Combine

public protocol SigninUseCase {
    func execute() -> AnyPublisher<Void, AuthDomainError>
}
