import BaseDomainInterface
import Localization
import SelfStudyDomainInterface
import UserDomainInterface

extension SelfStudyStatusType {
    func buttonDisplay(userRole: UserRoleType) -> String {
        guard userRole == .member else {
            return L10n.Home.modifyLimitButtonTitle
        }
        switch self {
        case .can: return L10n.Home.canSelfStudyButtonTitle
        case .applied: return L10n.Home.appliedSelfStudyButtonTitle
        case .cant: return L10n.Home.cantApplyButtonTitle
        case .impossible: return L10n.Home.impossibleSelfStudyButtonTitle
        }
    }

    func buttonIsEnabled(userRole: UserRoleType) -> Bool {
        guard userRole == .member else {
            return true
        }
        switch self {
        case .can, .applied: return true
        case .cant, .impossible: return false
        }
    }
}
