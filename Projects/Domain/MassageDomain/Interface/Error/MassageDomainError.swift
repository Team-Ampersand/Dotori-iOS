import Foundation
import Localization

public enum MassageDomainError: Error {
    // MARK: ApplyMassage
    case massageLimitExceeded
}

extension MassageDomainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .massageLimitExceeded:
            return L10n.Massage.massageLimitExceeded
        }
    }
}
