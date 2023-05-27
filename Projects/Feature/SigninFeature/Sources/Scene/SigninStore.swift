import AuthDomainInterface
import BaseFeature
import Combine
import ConcurrencyUtil
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

        Task.catching {
            try await self.signinUseCase.execute(req: req)
            self.route.send(DotoriRoutePath.main)
        } catch: { error in
            await DotoriToast.makeToast(text: error.localizedDescription, style: .error)
        }
    }
}
