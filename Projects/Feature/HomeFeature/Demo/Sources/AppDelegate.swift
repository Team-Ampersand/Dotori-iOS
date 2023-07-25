import Combine
import Inject
import UIKit
@testable import HomeFeature
@testable import TimerTesting
@testable import SelfStudyDomainTesting
@testable import MassageDomainTesting
@testable import MealDomainTesting
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
        let applySelfStudyUseCase: ApplySelfStudyUseCaseSpy = .init()
        let cancelSelfStudyUseCase = CancelSelfStudyUseCaseSpy()
        let applyMassageUseCase: ApplyMassageUseCaseSpy = .init()
        let cancelMassageUseCase = CancelMassageUseCaseSpy()
        let store = HomeStore(
            repeatableTimer: repeatableTimerStub,
            fetchSelfStudyInfoUseCase: fetchSelfStudyInfoUseCase,
            fetchMassageInfoUseCase: fetchMassageInfoUseCase,
            fetchMealInfoUseCase: fetchMealInfoUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase,
            applySelfStudyUseCase: applySelfStudyUseCase,
            cancelSelfStudyUseCase: cancelSelfStudyUseCase,
            applyMassageUseCase: applyMassageUseCase,
            cancelMassageUseCase: cancelMassageUseCase
        )
        let viewController = Inject.ViewControllerHost(
            UINavigationController(rootViewController: HomeViewController(store: store))
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
