import Inject
import UIKit
@testable import MusicFeature
@testable import MusicDomainTesting
@testable import UserDomainTesting

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let fetchMusicListUseCase = FetchMusicListUseCaseSpy()
        let loadCurrentUserRoleUseCase = LoadCurrentUserRoleUseCaseSpy()
        let store = MusicStore(
            fetchMusicListUseCase: fetchMusicListUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
        let viewController = Inject.ViewControllerHost(
            UINavigationController(rootViewController: MusicViewController(store: store))
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
