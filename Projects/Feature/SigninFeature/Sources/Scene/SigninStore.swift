import AuthDomainInterface
import BaseFeature
import Combine
import DesignSystem
import Moordinator
import Store

final class SigninStore: BaseStore {
    private let signinUseCase: any SigninUseCase
    let route: PassthroughSubject<RoutePath, Never> = .init()
    var initialState: State
    var subscription: Set<AnyCancellable> = .init()

    init(
        signinUseCase: any SigninUseCase
    ) {
        self.initialState = .init()
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
    enum Mutation {
        case updateEmail(String)
        case updatePassword(String)
    }

    let stateSubject = CurrentValueSubject<State, Never>(State())

    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case let .updateEmail(email):
            return .just(.updateEmail(email))

        case let .updatePassword(password):
            return .just(.updatePassword(password))

        case .signupButtonDidTap:
            route.send(DotoriRoutePath.signup)

        case .renewalPasswordButtonDidTap:
            route.send(DotoriRoutePath.renewalPassword)

        case .signinButtonDidTap:
            signinButtonDidTap(email: state.email, password: state.password)

        default:
            return .none
        }
        return .none
    }

    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateEmail(email):
            newState.email = email

        case let .updatePassword(password):
            newState.password = password
        }
        return newState
    }

    func signinButtonDidTap(email: String, password: String) {
        let req = SigninRequestDTO(email: email, password: password)
        signinUseCase.execute(req: req)
            .sink(with: self, receiveCompletion: { _, completion in
                if case let .failure(err) = completion {
                    DotoriToast.makeToast(text: err.errorDescription, style: .error)
                }
            }, receiveValue: { owner, _ in
                owner.route.send(DotoriRoutePath.main)
            })
            .store(in: &subscription)
    }
}
