import BaseDomainInterface
import Localization
import MassageDomainInterface
import UserDomainInterface

extension MassageStatusType {
    func buttonDisplay(userRole: UserRoleType) -> String {
        switch self {
        case .can: return L10n.Home.canMassageButtonTitle
        case .cant: return L10n.Home.cantApplyButtonTitle
        case .applied: return L10n.Home.appliedMassageButtonTitle
        }
    }

    func buttonIsEnabled(userRole: UserRoleType) -> Bool {
        switch self {
        case .can, .applied: return true
        case .cant: return false
        }
    }
}
