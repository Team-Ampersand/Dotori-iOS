import Combine
@testable import HomeFeature
import Inject
@testable import MassageDomainTesting
@testable import MealDomainTesting
@testable import SelfStudyDomainTesting
@testable import TimerTesting
import UIKit
@testable import UserDomainTesting

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let repeatableTimerStub = RepeatableTimerStub()
        repeatableTimerStub.repeatPublisherClosure = { _, _, _ in
            Timer.publish(every: 1, on: .main, in: .default)
                .autoconnect()
                .eraseToAnyPublisher()
        }
        let fetchSelfStudyInfoUseCase: FetchSelfStudyInfoUseCaseSpy = .init()
        let fetchMassageInfoUseCase: FetchMassageInfoUseCaseSpy = .init()
        let fetchMealInfoUseCase: FetchMealInfoUseCaseSpy = .init()
        let loadCurrentUserRoleUseCase: LoadCurrentUserRoleUseCaseSpy = .init()
        loadCurrentUserRoleUseCase.loadCurrentUserRoleReturn = .developer
        let applySelfStudyUseCase: ApplySelfStudyUseCaseSpy = .init()
        let cancelSelfStudyUseCase = CancelSelfStudyUseCaseSpy()
        let modifySelfStudyPersonnelUseCase = ModifySelfStudyPersonnelUseCaseSpy()
        let applyMassageUseCase: ApplyMassageUseCaseSpy = .init()
        let cancelMassageUseCase = CancelMassageUseCaseSpy()
        let modifyMassagePersonnelUseCase = ModifyMassagePersonnelUseCaseSpy()
        let logoutUseCase = LogoutUseCaseSpy()
        let withdrawalUseCase = WithdrawalUseCaseSpy()
        let store = HomeStore(
            repeatableTimer: repeatableTimerStub,
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
        let viewController = Inject.ViewControllerHost(
            UINavigationController(rootViewController: HomeViewController(store: store))
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
