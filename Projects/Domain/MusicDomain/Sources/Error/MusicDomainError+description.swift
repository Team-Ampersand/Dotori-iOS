import Foundation
import Localization
import MusicDomainInterface

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
