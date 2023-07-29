import Inject
import UIKit
@testable import DetailNoticeFeature
@testable import NoticeDomainTesting

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let fetchNoticeUseCase = FetchNoticeUseCaseSpy()
        let store = DetailNoticeStore(
            fetchNoticeUseCase: fetchNoticeUseCase
        )
        let viewController = Inject.ViewControllerHost(
            UINavigationController(rootViewController: DetailNoticeViewController(store: store))
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
