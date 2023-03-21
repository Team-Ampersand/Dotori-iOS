import AuthDomainInterface
import BaseFeature
import Combine
import SigninFeatureInterface
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
        case signupButtonDidTap
        case renewalPasswordButtonDidTap
    }

    let stateSubject = CurrentValueSubject<State, Never>(State())

    func process(_ action: Action) {
        let currentState = stateSubject.value
        var newState = currentState

        switch action {
        case .signupButtonDidTap:
            router.route.send(SigninRoutePath.signup)

        case .renewalPasswordButtonDidTap:
            router.route.send(SigninRoutePath.renewalPassword)
        }

        stateSubject.send(newState)
    }
}
