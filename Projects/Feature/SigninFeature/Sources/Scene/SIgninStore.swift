import AuthDomainInterface
import BaseFeature
import Combine
import DesignSystem
import SigninFeatureInterface
import Moordinator

final class SigninStore: BaseStore, RouterProvidable {
    private let signinUseCase: any SigninUseCase
    let router: any Router
    var bag: Set<AnyCancellable> = .init()

    init(
        router: any Router,
        signinUseCase: any SigninUseCase
    ) {
        self.router = router
        self.signinUseCase = signinUseCase
    }

    struct State: Equatable {
        var email: String = ""
        var password: String = ""
    }
    enum Action: Equatable {
        case updateEmail(String)
        case updatePassword(String)
        case signupButtonDidTap
        case renewalPasswordButtonDidTap
        case signinButtonDidTap
    }

    let stateSubject = CurrentValueSubject<State, Never>(State())

    func process(_ action: Action) {
        let currentState = stateSubject.value
        var newState = currentState

        switch action {
        case let .updateEmail(email):
            newState.email = email

        case let .updatePassword(password):
            newState.password = password

        case .signupButtonDidTap:
            router.route.send(SigninRoutePath.signup)

        case .renewalPasswordButtonDidTap:
            router.route.send(SigninRoutePath.renewalPassword)

        case .signinButtonDidTap:
            signinButtonDidTap(email: newState.email, password: newState.password)
        }

        stateSubject.send(newState)
    }

    func signinButtonDidTap(email: String, password: String) {
        let req = SigninRequestDTO(email: email, password: password)
        signinUseCase.execute(req: req)
            .sink(with: self, receiveCompletion: { owner, completion in
                if case let .failure(err) = completion {
                    let toastPath = SigninRoutePath.toast(
                        text: err.localizedDescription,
                        style: .error
                    )
                    owner.router.route.send(toastPath)
                }
            }, receiveValue: { owner, _ in
                owner.router.route.send(SigninRoutePath.main)
            })
            .store(in: &bag)
    }
}
