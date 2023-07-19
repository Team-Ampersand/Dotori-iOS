import Foundation
import Localization
import SelfStudyDomainInterface

extension SelfStudyDomainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .selfStudyLimitExceeded:
            return L10n.SelfStudy.selfStudyLimitExceeded
        }
    }
}
