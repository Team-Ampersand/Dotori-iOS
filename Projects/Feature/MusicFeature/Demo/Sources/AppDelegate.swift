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
        fetchMusicListUseCase.fetchMusicListHandler = { _ in
            [
                .init(id: 1, url: "https://youtu.be/yg9sW237Seg", title: "제목", thumbnailUIImage: nil, username: "김김김", createdTime: .init(), stuNum: "1111")
            ]
        }
        let removeMusicUseCase = RemoveMusicUseCaseSpy()
        let loadCurrentUserRoleUseCase = LoadCurrentUserRoleUseCaseSpy()
        loadCurrentUserRoleUseCase.loadCurrentUserRoleReturn = .developer
        let store = MusicStore(
            fetchMusicListUseCase: fetchMusicListUseCase,
            removeMusicUseCase: removeMusicUseCase,
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
