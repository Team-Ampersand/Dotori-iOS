import ConfirmationDialogFeature
import InputDialogFeatureInterface
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
    private let modifySelfStudyPersonnelUseCase: any ModifySelfStudyPersonnelUseCase
    private let applyMassageUseCase: any ApplyMassageUseCase
    private let cancelMassageUseCase: any CancelMassageUseCase
    private let modifyMassagePersonnelUseCase: any ModifyMassagePersonnelUseCase
    private let logoutUseCase: any LogoutUseCase
    private let withdrawalUseCase: any WithdrawalUseCase
    private let confirmationDialogFactory: any ConfirmationDialogFactory
    private let myViolationListFactory: any MyViolationListFactory
    private let inputDialogFactory: any InputDialogFactory

    init(
        repeatableTimer: any RepeatableTimer,
        fetchSelfStudyInfoUseCase: any FetchSelfStudyInfoUseCase,
        fetchMassageInfoUseCase: any FetchMassageInfoUseCase,
        fetchMealInfoUseCase: any FetchMealInfoUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase,
        applySelfStudyUseCase: any ApplySelfStudyUseCase,
        cancelSelfStudyUseCase: any CancelSelfStudyUseCase,
        modifySelfStudyPersonnelUseCase: any ModifySelfStudyPersonnelUseCase,
        applyMassageUseCase: any ApplyMassageUseCase,
        cancelMassageUseCase: any CancelMassageUseCase,
        modifyMassagePersonnelUseCase: any ModifyMassagePersonnelUseCase,
        logoutUseCase: any LogoutUseCase,
        withdrawalUseCase: any WithdrawalUseCase,
        confirmationDialogFactory: any ConfirmationDialogFactory,
        myViolationListFactory: any MyViolationListFactory,
        inputDialogFactory: any InputDialogFactory
    ) {
        self.repeatableTimer = repeatableTimer
        self.fetchSelfStudyInfoUseCase = fetchSelfStudyInfoUseCase
        self.fetchMassageInfoUseCase = fetchMassageInfoUseCase
        self.fetchMealInfoUseCase = fetchMealInfoUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
        self.applySelfStudyUseCase = applySelfStudyUseCase
        self.cancelSelfStudyUseCase = cancelSelfStudyUseCase
        self.modifySelfStudyPersonnelUseCase = modifySelfStudyPersonnelUseCase
        self.applyMassageUseCase = applyMassageUseCase
        self.cancelMassageUseCase = cancelMassageUseCase
        self.modifyMassagePersonnelUseCase = modifyMassagePersonnelUseCase
        self.logoutUseCase = logoutUseCase
        self.withdrawalUseCase = withdrawalUseCase
        self.confirmationDialogFactory = confirmationDialogFactory
        self.myViolationListFactory = myViolationListFactory
        self.inputDialogFactory = inputDialogFactory
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
            modifySelfStudyPersonnelUseCase: modifySelfStudyPersonnelUseCase,
            applyMassageUseCase: applyMassageUseCase,
            cancelMassageUseCase: cancelMassageUseCase,
            modifyMassagePersonnelUseCase: modifyMassagePersonnelUseCase,
            logoutUseCase: logoutUseCase,
            withdrawalUseCase: withdrawalUseCase
        )
        let homeViewController = HomeViewController(store: homeStore)
        return HomeMoordinator(
            homeViewController: homeViewController,
            confirmationDialogFactory: confirmationDialogFactory,
            myViolationListFactory: myViolationListFactory,
            inputDialogFactory: inputDialogFactory
        )
    }
}
