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
        initialState = .init()
        stateSubject = .init(initialState)
        self.checkIsLoggedInUseCase = checkIsLoggedInUseCase
    }

    struct State {}
    enum Action {}
    enum Mutation {}

    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        .none
    }

    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        return newState
    }
}
