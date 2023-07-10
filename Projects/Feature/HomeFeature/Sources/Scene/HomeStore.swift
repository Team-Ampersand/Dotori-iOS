import BaseFeature
import Combine
import Store
import Moordinator

final class HomeStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>

    init() {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
    }

    struct State: Equatable {}
    enum Action: Equatable {
        case myInfoBarButtonDidTap
    }
    enum Mutation {}
}

extension HomeStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .myInfoBarButtonDidTap:
            return myInfoBarButtonDidTap()

        default:
            return .none
        }
    }
}

extension HomeStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        return newState
    }
}

private extension HomeStore {
    func myInfoBarButtonDidTap() -> SideEffect<Mutation, Never> {
        let alertPath = DotoriRoutePath.alert(style: .actionSheet, actions: [
            .init(title: "프로필 수정", style: .default) { _ in },
            .init(title: "규정위반 내역", style: .default) { _ in },
            .init(title: "비밀번호 변경", style: .default) { _ in },
            .init(title: "로그아웃", style: .default) { _ in }
        ])
        self.route.send(alertPath)
        return .none
    }
}
