import Combine
import Foundation

public protocol LocalAuthDataSource {
    func loadJwtToken() -> AnyPublisher<JwtTokenEntity, Never>
}
