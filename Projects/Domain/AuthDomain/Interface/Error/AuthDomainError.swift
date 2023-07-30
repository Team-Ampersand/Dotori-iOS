import Foundation
import Localization

public enum AuthDomainError: Error {
    case unknown

    // MARK: Signin
    case invalidPassword

    // MARK: Refresh
    case refreshTokenExpired
}

extension AuthDomainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return L10n.Global.unknownError

        case .invalidPassword:
            return L10n.Signin.invalidPasswordError

        case .refreshTokenExpired:
            return L10n.Signin.refreshTokenExpired
        }
    }
}
