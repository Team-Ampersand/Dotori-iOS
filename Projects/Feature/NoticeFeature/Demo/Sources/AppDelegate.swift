import BaseDomainInterface
import Inject
import UIKit
@testable import NoticeFeature
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
        let fetchNoticeListUseCase = FetchNoticeListUseCaseSpy()
        fetchNoticeListUseCase.fetchNoticeListReturn = [
            .init(id: 1, title: "제목", content: "내용내용\n내용내용", roles: .developer, createdTime: .init()),
            .init(id: 2, title: "제목", content: "내용내용\n내용내용", roles: .developer, createdTime: .init().addingTimeInterval(TimeInterval(86400 * 31))),
            .init(id: 3, title: "제목", content: "내용내용\n내용내용냐용", roles: .member, createdTime: .init().addingTimeInterval(TimeInterval(86400 * 31 * 2))),
            .init(id: 4, title: "제목", content: "내용내용\n내용내용냐용", roles: .councillor, createdTime: .init().addingTimeInterval(TimeInterval(86400 * 31 * 2))),
            .init(id: 5, title: "제목", content: "내용내용\n내용내용냐용", roles: .admin, createdTime: .init().addingTimeInterval(TimeInterval(86400 * 31 * 2))),
            .init(id: 6, title: "제목", content: "내용내용\n내용내용\n내용", roles: .developer, createdTime: .init().addingTimeInterval(TimeInterval(86400 * 31 * 3)))
        ]

        let loadCurrentUserRoleUseCase = LoadCurrentUserRoleUseCaseSpy()
        let store = NoticeStore(
            fetchNoticeListUseCase: fetchNoticeListUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
        let viewController = Inject.ViewControllerHost(
            UINavigationController(rootViewController: NoticeViewController(store: store))
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
