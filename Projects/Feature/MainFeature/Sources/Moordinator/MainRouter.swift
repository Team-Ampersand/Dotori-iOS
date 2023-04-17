import BaseFeature
import Combine
import Moordinator

final class MainRouter: Router {
    let route: PassthroughSubject<any RoutePath, Never> = .init()
    var initialPath: RoutePath {
        DotoriRoutePath.main
    }
}
