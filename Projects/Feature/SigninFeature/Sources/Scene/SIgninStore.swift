import BaseFeature
import Combine
import Moordinator

final class SigninStore: BaseStore, RouterProvidable {
    let router: any Router

    init(router: any Router) {
        self.router = router
    }

    struct State: Equatable {
    }
    enum Action: Equatable {
    }

    let stateSubject = CurrentValueSubject<State, Never>(State())

    func process(_ action: Action) {
    }
}
