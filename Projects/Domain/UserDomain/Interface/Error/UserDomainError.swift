import Foundation
import Localization

public enum UserDomainError: Error {
    // MARK: LoadCurrentUserRole
    case cannotFindUserRole
}

extension UserDomainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cannotFindUserRole:
            return "Cannot find user role"
        }
    }
}
