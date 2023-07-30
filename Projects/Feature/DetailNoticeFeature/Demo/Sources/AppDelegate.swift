import Inject
import UIKit
@testable import DetailNoticeFeature
@testable import NoticeDomainTesting
@testable import UserDomainTesting

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let fetchNoticeUseCase = FetchNoticeUseCaseSpy()
        let removeNoticeUseCase = RemoveNoticeUseCaseSpy()
        let loadCurrentUserRoleUseCase = LoadCurrentUserRoleUseCaseSpy()
        loadCurrentUserRoleUseCase.loadCurrentUserRoleReturn = .developer
        let store = DetailNoticeStore(
            noticeID: 1,
            fetchNoticeUseCase: fetchNoticeUseCase,
            removeNoticeUseCase: removeNoticeUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
        let viewController = Inject.ViewControllerHost(
            UINavigationController(rootViewController: DetailNoticeViewController(store: store))
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
