import UIKit
import Inject
@testable import MassageFeature
@testable import MassageDomainTesting

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let fetchMassageRankListUseCase = FetchMassageRankListUseCaseSpy()
        fetchMassageRankListUseCase.fetchMassageRankListHandler = {
            [
                .init(id: 1, rank: 1, stuNum: "1234", memberName: "대충이름", gender: .man),
                .init(id: 2, rank: 2, stuNum: "1235", memberName: "대이충름", gender: .man),
                .init(id: 3, rank: 3, stuNum: "1236", memberName: "이름대충", gender: .woman)
            ]
        }
        let store = MassageStore(fetchMassageRankListUseCase: fetchMassageRankListUseCase)
        let viewController = Inject.ViewControllerHost(
            UINavigationController(rootViewController: MassageViewController(store: store))
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
