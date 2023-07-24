import BaseDomainInterface
import Foundation

public protocol LoadCurrentUserRoleUseCase {
    func callAsFunction() throws -> UserRoleType
}
