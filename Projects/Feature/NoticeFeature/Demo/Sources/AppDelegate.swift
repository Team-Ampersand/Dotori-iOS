import Inject
import UIKit
@testable import NoticeFeature

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let store = NoticeStore()
        let viewController = NoticeViewController(store: store)
        window?.rootViewController = Inject.ViewControllerHost(
            UINavigationController(rootViewController: viewController)
        )
        window?.makeKeyAndVisible()

        return true
    }
}
