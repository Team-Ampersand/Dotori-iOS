import Combine
import Foundation
import JwtStoreInterface

public protocol AuthRepository {
    func signin(req: SigninRequestDTO) -> AnyPublisher<Void, AuthDomainError>
    func loadJwtToken() -> JwtTokenEntity
}
