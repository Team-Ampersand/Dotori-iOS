import BaseFeature
import Combine
import Moordinator

final class RootRouter: Router {
    let route: PassthroughSubject<any RoutePath, Never> = .init()
    var initialPath: RoutePath {
        DotoriRoutePath.signin
    }
}
