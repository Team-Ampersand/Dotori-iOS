import Inject
import UIKit
@testable import SelfStudyFeature
@testable import SelfStudyDomainTesting

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        var fetchSelfStudyRankListUseCase = FetchSelfStudyRankListUseCaseSpy()
        let store = SelfStudyStore(fetchSelfStudyRankListUseCase: fetchSelfStudyRankListUseCase)
        let viewController = Inject.ViewControllerHost(
            UINavigationController(rootViewController: SelfStudyViewController(store: store))
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
