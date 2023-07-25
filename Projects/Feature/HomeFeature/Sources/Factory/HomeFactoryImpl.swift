import ConfirmationDialogFeature
import MassageDomainInterface
import MealDomainInterface
import Moordinator
import MyViolationListFeature
import SelfStudyDomainInterface
import TimerInterface
import UserDomainInterface

struct HomeFactoryImpl: HomeFactory {
    private let repeatableTimer: any RepeatableTimer
    private let fetchSelfStudyInfoUseCase: any FetchSelfStudyInfoUseCase
    private let fetchMassageInfoUseCase: any FetchMassageInfoUseCase
    private let fetchMealInfoUseCase: any FetchMealInfoUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    private let applySelfStudyUseCase: any ApplySelfStudyUseCase
    private let cancelSelfStudyUseCase: any CancelSelfStudyUseCase
    private let applyMassageUseCase: any ApplyMassageUseCase
    private let cancelMassageUseCase: any CancelMassageUseCase
    private let confirmationDialogFactory: any ConfirmationDialogFactory
    private let myViolationListFactory: any MyViolationListFactory

    init(
        repeatableTimer: any RepeatableTimer,
        fetchSelfStudyInfoUseCase: any FetchSelfStudyInfoUseCase,
        fetchMassageInfoUseCase: any FetchMassageInfoUseCase,
        fetchMealInfoUseCase: any FetchMealInfoUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase,
        applySelfStudyUseCase: any ApplySelfStudyUseCase,
        cancelSelfStudyUseCase: any CancelSelfStudyUseCase,
        applyMassageUseCase: any ApplyMassageUseCase,
        cancelMassageUseCase: any CancelMassageUseCase,
        confirmationDialogFactory: any ConfirmationDialogFactory,
        myViolationListFactory: any MyViolationListFactory
    ) {
        self.repeatableTimer = repeatableTimer
        self.fetchSelfStudyInfoUseCase = fetchSelfStudyInfoUseCase
        self.fetchMassageInfoUseCase = fetchMassageInfoUseCase
        self.fetchMealInfoUseCase = fetchMealInfoUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
        self.applySelfStudyUseCase = applySelfStudyUseCase
        self.cancelSelfStudyUseCase = cancelSelfStudyUseCase
        self.applyMassageUseCase = applyMassageUseCase
        self.cancelMassageUseCase = cancelMassageUseCase
        self.confirmationDialogFactory = confirmationDialogFactory
        self.myViolationListFactory = myViolationListFactory
    }

    func makeMoordinator() -> Moordinator {
        let homeStore = HomeStore(
            repeatableTimer: repeatableTimer,
            fetchSelfStudyInfoUseCase: fetchSelfStudyInfoUseCase,
            fetchMassageInfoUseCase: fetchMassageInfoUseCase,
            fetchMealInfoUseCase: fetchMealInfoUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase,
            applySelfStudyUseCase: applySelfStudyUseCase,
            cancelSelfStudyUseCase: cancelSelfStudyUseCase,
            applyMassageUseCase: applyMassageUseCase,
            cancelMassageUseCase: cancelMassageUseCase
        )
        let homeViewController = HomeViewController(store: homeStore)
        return HomeMoordinator(
            homeViewController: homeViewController,
            confirmationDialogFactory: confirmationDialogFactory,
            myViolationListFactory: myViolationListFactory
        )
    }
}
