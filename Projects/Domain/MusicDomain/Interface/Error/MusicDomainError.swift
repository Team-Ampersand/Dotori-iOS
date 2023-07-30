import Foundation
import Localization

public enum MusicDomainError: Error {
    // MARK: - ProposeMusic
    case unavilableDate
    case musicAlreadyProposed
}

extension MusicDomainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unavilableDate:
            return L10n.ProposeMusic.unavilablePropseDate

        case .musicAlreadyProposed:
            return L10n.ProposeMusic.alreadyProposedMusic
        }
    }
}
