import BaseDomainInterface
import Localization
import MassageDomainInterface
import UserDomainInterface

extension MassageStatusType {
    func buttonDisplay(userRole: UserRoleType) -> String {
        #warning("FIXME: 디자인 변경 대응 시 재활성화")
//        guard userRole == .member else {
//            return L10n.Home.modifyLimitButtonTitle
//        }
        switch self {
        case .can: return L10n.Home.canMassageButtonTitle
        case .cant: return L10n.Home.cantApplyButtonTitle
        case .applied: return L10n.Home.appliedMassageButtonTitle
        }
    }

    func buttonIsEnabled(userRole: UserRoleType) -> Bool {
        #warning("FIXME: 디자인 변경 대응 시 재활성화")
//        guard userRole == .member else {
//            return true
//        }
        switch self {
        case .can, .applied: return true
        case .cant: return false
        }
    }
}
