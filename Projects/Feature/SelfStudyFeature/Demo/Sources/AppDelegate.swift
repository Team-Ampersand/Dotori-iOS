import BaseDomainInterface
import Inject
@testable import SelfStudyDomainTesting
@testable import SelfStudyFeature
import UIKit
@testable import UserDomainTesting

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let fetchSelfStudyRankListUseCase = FetchSelfStudyRankListUseCaseSpy()
        fetchSelfStudyRankListUseCase.fetchSelfStudyRankListReturn = [
            .init(id: 1, rank: 1, stuNum: "3107", memberName: "김준", gender: .man, selfStudyCheck: false),
            .init(id: 2, rank: 2, stuNum: "3216", memberName: "전승원", gender: .man, selfStudyCheck: true),
            .init(id: 3, rank: 3, stuNum: "3111", memberName: "선민재", gender: .woman, selfStudyCheck: false)
        ]
        let loadCurrentUserRoleUseCase = LoadCurrentUserRoleUseCaseSpy()
        let checkSelfStudyMemberUseCase = CheckSelfStudyMemberUseCaseSpy()
        let store = SelfStudyStore(
            fetchSelfStudyRankListUseCase: fetchSelfStudyRankListUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase,
            checkSelfStudyMemberUseCase: checkSelfStudyMemberUseCase
        )
        let viewController = Inject.ViewControllerHost(
            UINavigationController(rootViewController: SelfStudyViewController(store: store))
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
