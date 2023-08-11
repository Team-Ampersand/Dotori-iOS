import Inject
@testable import MyViolationListFeature
import UIKit
@testable import ViolationDomainTesting

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let fetchMyViolationListUseCase = FetchMyViolationListUseCaseSpy()
        fetchMyViolationListUseCase.fetchMyViolationListHandler = {
            [
                .init(id: 1, rule: "긱사 탈출", createDate: .init()),
                .init(id: 2, rule: "라면 취식", createDate: .init()),
                .init(id: 2, rule: "대충 긴글대충 긴글대충 긴글대충 긴글대충 긴글대충 긴글", createDate: .init())
            ]
        }
        let store = MyViolationListStore(
            fetchMyViolationListUseCase: fetchMyViolationListUseCase
        )
        let viewController = Inject.ViewControllerHost(
            MyViolationListViewController(store: store)
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
