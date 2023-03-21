import Foundation

public enum RefreshError: Error {
    case unknown
    case expiredToken
    case invalidToken
    case underlying(Error)
}

extension RefreshError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "알 수 없는 오류가 발생했습니다. 지속될 시 문의해주세요."

        case .expiredToken, .invalidToken:
            return "로그인 세션이 만료되었습니다. 앱을 종료 후 다시 로그인해주세요."

        case let .underlying(error):
            return error.localizedDescription
        }
    }
}
