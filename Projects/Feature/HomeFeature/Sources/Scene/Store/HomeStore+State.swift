import BaseDomainInterface
import Foundation
import Localization
import MassageDomainInterface
import MealDomainInterface
import SelfStudyDomainInterface
import UserDomainInterface

extension HomeStore {
    struct State {
        var currentTime: Date = .init()
        var currentUserRole: UserRoleType = .member
        var profileImageUrl: String? = ""
        var selfStudyInfo: (Int, Int) = (0, 0)
        var massageInfo: (Int, Int) = (0, 0)
        var selectedMealDate: Date = Date()
        var selectedMealType: MealType = .breakfast
        var mealInfo: [MealInfoModel] = []
        var loadingState: Set<HomeLoadingState> = []
        var selfStudyStatus: SelfStudyStatusType = .cant
        var massageStatus: MassageStatusType = .cant
        var selfStudyButtonTitle: String = L10n.Home.cantApplyButtonTitle
        var massageButtonTitle: String = L10n.Home.cantApplyButtonTitle
        var selfStudyButtonIsEnabled: Bool = false
        var massageButtonIsEnabled: Bool = false
        var selfStudyRefreshDate: Date = Date()
        var massageRefreshDate: Date = Date()
    }

    enum Mutation {
        case updateCurrentTime(Date)
        case updateCurrentUserRole(UserRoleType)
        case updateProfileImage(String)
        case updateSelfStudyInfo((Int, Int))
        case updateMassageInfo((Int, Int))
        case updateSelectedMealDate(Date)
        case updateSelectedMealType(MealType)
        case updateMealInfo([MealInfoModel])
        case insertLoadingState(HomeLoadingState)
        case removeLoadingState(HomeLoadingState)
        case updateSelfStudyStatus(SelfStudyStatusType)
        case updateMassageStatus(MassageStatusType)
        case updateSelfStudyRefreshDate(Date)
        case updateMassageRefreshDate(Date)
    }
}

extension HomeStore {
    // swiftlint: disable cyclomatic_complexity
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state

        switch mutate {
        case let .updateCurrentTime(date):
            newState.currentTime = date

        case let .updateCurrentUserRole(userRole):
            newState.currentUserRole = userRole

        case let .updateProfileImage(profileImageUrl):
            newState.profileImageUrl = profileImageUrl

        case let .updateSelfStudyInfo(selfStudyInfo):
            newState.selfStudyInfo = selfStudyInfo

        case let .updateMassageInfo(massageInfo):
            newState.massageInfo = massageInfo

        case let .updateSelectedMealDate(date):
            newState.selectedMealDate = date

        case let .updateSelectedMealType(type):
            newState.selectedMealType = type

        case let .updateMealInfo(mealInfo):
            newState.mealInfo = mealInfo

        case let .insertLoadingState(loadingState):
            newState.loadingState.insert(loadingState)

        case let .removeLoadingState(loadingState):
            newState.loadingState.remove(loadingState)

        case let .updateSelfStudyStatus(status):
            newState.selfStudyStatus = status
            let userRole = currentState.currentUserRole
            newState.selfStudyButtonTitle = status.buttonDisplay(userRole: userRole)
            newState.selfStudyButtonIsEnabled = status.buttonIsEnabled(userRole: userRole)

        case let .updateMassageStatus(status):
            newState.massageStatus = status
            let userRole = currentState.currentUserRole
            newState.massageButtonTitle = status.buttonDisplay(userRole: userRole)
            newState.massageButtonIsEnabled = status.buttonIsEnabled(userRole: userRole)

        case let .updateSelfStudyRefreshDate(date):
            newState.selfStudyRefreshDate = date

        case let .updateMassageRefreshDate(date):
            newState.massageRefreshDate = date
        }

        return newState
    }
    // swiftlint: enable cyclomatic_complexity
}
