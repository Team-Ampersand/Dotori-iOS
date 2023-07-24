import UIKit
import Inject
@testable import SelfStudyFeature

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let store = SelfStudyStore()
        let viewController = Inject.ViewControllerHost(
            UINavigationController(rootViewController: SelfStudyViewController(store: store))
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
