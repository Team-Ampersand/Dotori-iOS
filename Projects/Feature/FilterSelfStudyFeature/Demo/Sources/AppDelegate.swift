@testable import FilterSelfStudyFeature
import Inject
import UIKit
import UIKitUtil

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let store = FilterSelfStudyStore { _, _, _, _ in }
        let viewController = Inject.ViewControllerHost(
            FilterSelfStudyViewController(store: store)
        )
        let viewContr = UIViewController()
        viewContr.view.backgroundColor = .blue
        window?.rootViewController = viewContr
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            viewContr.modalPresent(viewController, animated: false)
        }
        window?.makeKeyAndVisible()

        return true
    }
}
