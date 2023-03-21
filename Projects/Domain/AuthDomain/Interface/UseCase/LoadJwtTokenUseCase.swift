import Combine

public protocol LoadJwtTokenUseCase {
    func execute() -> AnyPublisher<JwtTokenEntity, Never>
}
