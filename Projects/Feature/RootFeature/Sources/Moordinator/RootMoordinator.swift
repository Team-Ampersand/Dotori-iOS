import BaseFeature
import Combine
import MainTabFeature
import Moordinator
import SigninFeature
import UIKit

public final class RootMoordinator: Moordinator {
    private let window: UIWindow
    private let signinFactory: any SigninFactory
    private let mainFactory: any MainFactory
    private lazy var rootVC: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        return viewController
    }()

    public var root: Presentable {
        rootVC
    }

    public init(
        window: UIWindow,
        signinFactory: any SigninFactory,
        mainFactory: any MainFactory
    ) {
        self.window = window
        self.signinFactory = signinFactory
        self.mainFactory = mainFactory
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
    }

    public func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .signin:
            let signinMoordinator = signinFactory.makeMoordinator()
            Moord.use(signinMoordinator) { root in
                UIView.transition(
                    with: self.window,
                    duration: 0.3,
                    options: .transitionCrossDissolve
                ) {
                    self.window.rootViewController = root
                }
            }
            return .one(
                .contribute(
                    withNextPresentable: signinMoordinator,
                    withNextRouter: DisposableRouter(singlePath: DotoriRoutePath.signin)
                )
            )

        case .main:
            let mainMoordinator = mainFactory.makeMoordinator()
            Moord.use(mainMoordinator) { root in
                UIView.transition(
                    with: self.window,
                    duration: 0.3,
                    options: .transitionCrossDissolve
                ) {
                    self.window.rootViewController = root
                }
            }
            return .one(
                .contribute(
                    withNextPresentable: mainMoordinator,
                    withNextRouter: DisposableRouter(singlePath: DotoriRoutePath.main)
                )
            )

        default:
            return .none
        }
    }
}
