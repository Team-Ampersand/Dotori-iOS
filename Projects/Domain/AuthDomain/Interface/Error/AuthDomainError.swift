import Foundation

public enum AuthDomainError: Error {
    case unknown

    // MARK: Signin
    case invalidPassword
}

extension AuthDomainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "알 수 없는 오류가 발생했습니다. 지속될 시 문의해주세요."

        case .invalidPassword:
            return "이메일 혹은 비밀번호가 일치하지 않습니다."
        }
    }
}
