import UIKit
import Moordinator

final class SigninMoordinator: Moordinator {
    private let rootVC: UIViewController = {
        let vc = UIViewController(nibName: nil, bundle: nil)
        vc.view.backgroundColor = .blue
        return vc
    }()
    let router: any Router = SigninRouter()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        return .none
    }
}
