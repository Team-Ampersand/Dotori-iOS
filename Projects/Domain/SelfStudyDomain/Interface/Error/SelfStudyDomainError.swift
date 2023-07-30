import Foundation
import Localization

public enum SelfStudyDomainError: Error {
    // MARK: ApplySelfStudy
    case selfStudyLimitExceeded
}

extension SelfStudyDomainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .selfStudyLimitExceeded:
            return L10n.SelfStudy.selfStudyLimitExceeded
        }
    }
}
