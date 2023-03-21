import Combine
import Foundation

public protocol RemoteAuthDataSource {
    func signin() -> AnyPublisher<Void, AuthDomainError>
    
}
