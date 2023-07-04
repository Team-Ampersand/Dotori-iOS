import Foundation
import Localization
import UserDomainInterface

extension UserDomainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cannotFindUserRole:
            return "Cannot find user role"
        }
    }
}
