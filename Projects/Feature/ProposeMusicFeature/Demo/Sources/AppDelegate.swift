import Inject
import UIKit
@testable import ProposeMusicFeature
@testable import MusicDomainTesting

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let proposeMusicUseCase = ProposeMusicUseCaseSpy()
        let store = ProposeMusicStore(
            proposeMusicUseCase: proposeMusicUseCase
        )
        let viewController = Inject.ViewControllerHost(
            ProposeMusicViewController(store: store)
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
