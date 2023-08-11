import AuthDomainInterface
import BaseFeature
import Combine
import Moordinator
import Store

final class SplashStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let checkIsLoggedInUseCase: any CheckIsLoggedInUseCase

    init(checkIsLoggedInUseCase: any CheckIsLoggedInUseCase) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.checkIsLoggedInUseCase = checkIsLoggedInUseCase
    }

    struct State {}
    enum Action {
        case viewDidLoad
    }

    enum Mutation {}

    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .viewDidLoad:
            viewDidLoad()
        }
        return .none
    }

    func reduce(state: State, mutate: Mutation) -> State {
        return state
    }
}

private extension SplashStore {
    func viewDidLoad() {
        Task {
            let isLoggedIn = await checkIsLoggedInUseCase()
            let routePath = isLoggedIn ? DotoriRoutePath.main : .signin
            route.send(routePath)
        }
    }
}
