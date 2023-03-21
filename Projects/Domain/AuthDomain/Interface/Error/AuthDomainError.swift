import Foundation

public enum AuthDomainError: Error {
    // MARK: Signin
    case invalidPassword
}

extension AuthDomainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidPassword:
            return "이메일 혹은 비밀번호가 일치하지 않습니다."
        }
    }
}
