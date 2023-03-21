import Combine
import Foundation
import JwtStoreInterface

public protocol AuthRepository {
    func signin() -> AnyPublisher<Void, AuthDomainError>
    func loadJwtToken() -> AnyPublisher<JwtTokenEntity, AuthDomainError>
}
