import Inject
import UIKit
@testable import NoticeFeature
@testable import NoticeDomainTesting

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let fetchNoticeListUseCase = FetchNoticeListUseCaseSpy()
        fetchNoticeListUseCase.fetchNoticeListReturn = [
            .init(id: 1, title: "제목", content: "내용내용\n내용내용", roles: .developer, createdTime: .init())
        ]
        let store = NoticeStore(fetchNoticeListUseCase: fetchNoticeListUseCase)
        let viewController = Inject.ViewControllerHost(
            UINavigationController(rootViewController: NoticeViewController(store: store))
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
