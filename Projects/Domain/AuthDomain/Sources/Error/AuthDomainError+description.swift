import AuthDomainInterface
import Foundation
import Localization

extension AuthDomainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return L10n.Global.unknownError

        case .invalidPassword:
            return L10n.Signin.invalidPasswordError
        }
    }
}
