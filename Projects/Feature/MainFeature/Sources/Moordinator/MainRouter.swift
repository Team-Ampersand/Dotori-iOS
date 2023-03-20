import Combine
import MainFeatureInterface
import Moordinator

final class MainRouter: Router {
    let route: PassthroughSubject<any RoutePath, Never> = .init()
    var initialPath: RoutePath {
        MainRoutePath.main
    }
}
