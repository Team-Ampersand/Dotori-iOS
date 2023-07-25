import Inject
import UIKit
@testable import MyViolationHistoryFeature

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let store = MyViolationHistoryStore()
        let viewController = Inject.ViewControllerHost(
            MyViolationHistoryViewController(store: store)
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
