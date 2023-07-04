import Foundation
import Localization

extension UserDomainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cannotFindUserRole:
            return "유저의 권한을 찾을 수 없습니다. 다시 로그인해주세요."
        }
    }
}
