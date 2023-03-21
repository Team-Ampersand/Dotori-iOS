import Combine

public protocol LoadJwtTokenUseCase {
    func execute() -> JwtTokenEntity
}
