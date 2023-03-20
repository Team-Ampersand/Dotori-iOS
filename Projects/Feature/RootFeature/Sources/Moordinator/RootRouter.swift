import Combine
import Moordinator
import RootFeatureInterface

final class RootRouter: Router {
    let route: PassthroughSubject<any RoutePath, Never> = .init()
    var initialPath: RoutePath {
        RootRoutePath.auth
    }
}
