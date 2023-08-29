import BaseFeature
import DesignSystem
import Moordinator
import RenewalPasswordFeatureInterface
import SignupFeatureInterface
import UIKit

final class SigninMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    private let signinViewController: SigninViewController
    private let signupFactory: any SignupFactory
    private let renewalPasswordFactory: any RenewalPasswordFactory

    init(
        signinViewController: SigninViewController,
        signupFactory: any SignupFactory,
        renewalPasswordFactory: any RenewalPasswordFactory
    ) {
        self.signinViewController = signinViewController
        self.signupFactory = signupFactory
        self.renewalPasswordFactory = renewalPasswordFactory
    }

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .signin:
            rootVC.setViewControllers([signinViewController], animated: true)
            return .one(
                .contribute(
                    withNextPresentable: signinViewController,
                    withNextRouter: signinViewController.store
                )
            )

        case .signup:
            let viewController = signupFactory.makeViewController { [rootVC] in
                print("ASD")
                rootVC.popViewController(animated: true)
            }
            rootVC.pushViewController(viewController, animated: true)
            return .one(.contribute(withNextPresentable: viewController))

        case .renewalPassword:
            let viewController = renewalPasswordFactory.makeViewController { [rootVC] in
                print("ASD")
                rootVC.popViewController(animated: true)
            }
            rootVC.pushViewController(viewController, animated: true)
            return .one(.contribute(withNextPresentable: viewController))

        case .main:
            return .end(DotoriRoutePath.main)

        default:
            return .none
        }
        return .none
    }
}
