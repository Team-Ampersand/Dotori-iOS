import AuthDomainInterface
import BaseFeature
import Combine
import Moordinator

final class SigninStore: BaseStore, RouterProvidable {
    private let signinUseCase: any SigninUseCase
    let router: any Router

    init(
        router: any Router,
        signinUseCase: any SigninUseCase
    ) {
        self.router = router
        self.signinUseCase = signinUseCase
    }

    struct State: Equatable {
    }
    enum Action: Equatable {
    }

    let stateSubject = CurrentValueSubject<State, Never>(State())

    func process(_ action: Action) {
    }
}
