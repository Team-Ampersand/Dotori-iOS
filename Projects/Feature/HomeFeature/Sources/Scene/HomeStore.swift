import BaseFeature
import Combine
import Foundation
import Moordinator
import Store

final class HomeStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>

    init() {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
    }

    struct State: Equatable {
        var currentTime: Date = .init()
    }
    enum Action: Equatable {
        case viewDidLoad
        case myInfoButtonDidTap
    }
    enum Mutation {
        case updateCurrentTime(Date)
    }
}

extension HomeStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .viewDidLoad:
            return Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .map { Mutation.updateCurrentTime($0) }
                .eraseToSideEffect()

        case .myInfoButtonDidTap:
            return myInfoButtonDidTap()

        default:
            return .none
        }
    }
}

extension HomeStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state

        switch mutate {
        case let .updateCurrentTime(date):
            newState.currentTime = date
        }

        return newState
    }
}

private extension HomeStore {
    func myInfoButtonDidTap() -> SideEffect<Mutation, Never> {
        let alertPath = DotoriRoutePath.alert(style: .actionSheet, actions: [
            .init(title: "프로필 수정", style: .default) { _ in },
            .init(title: "규정위반 내역", style: .default) { _ in },
            .init(title: "비밀번호 변경", style: .default) { _ in },
            .init(title: "로그아웃", style: .default) { _ in },
            .init(title: "취소", style: .cancel)
        ])
        self.route.send(alertPath)
        return .none
    }
}
