import Combine
import SigninFeatureInterface
import Moordinator

final class SigninRouter: Router {
    let route: PassthroughSubject<any RoutePath, Never> = .init()
    var initialPath: RoutePath {
        SigninRoutePath.signin
    }
}
