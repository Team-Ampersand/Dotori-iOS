import Foundation

public enum AuthDomainError: Error {
    case unknown

    // MARK: Signin
    case invalidPassword

    // MARK: Refresh
    case refreshTokenExpired
}
