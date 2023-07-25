import Inject
import UIKit
@testable import MyViolationListFeature
@testable import ViolationDomainTesting

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let fetchMyViolationListUseCase = FetchMyViolationListUseCaseSpy()
        let store = MyViolationListStore(
            fetchMyViolationListUseCase: fetchMyViolationListUseCase
        )
        let viewController = Inject.ViewControllerHost(
            MyViolationListViewController(store: store)
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
