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
        var code: String = ""
    }

    enum Action: Equatable {
        case signupButtonDidTap
        case renewalPasswordButtonDidTap
        case signinButtonDidTap
    }

    enum Mutation {
        case updateCode(String)
    }

    let stateSubject = CurrentValueSubject<State, Never>(State())

    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .signupButtonDidTap:
            route.send(DotoriRoutePath.signup)

        case .renewalPasswordButtonDidTap:
            route.send(DotoriRoutePath.renewalPassword)

        case .signinButtonDidTap:
            signinButtonDidTap(code: state.code)

        default:
            return .none
        }
        return .none
    }

    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateCode(code):
            newState.code = code
        }
        return newState
    }

    func signinButtonDidTap(code: String) {
        let req = SigninRequestDTO(code: code)

        Task.catching {
            try await self.signinUseCase.execute(req: req)
            self.route.send(DotoriRoutePath.main)
        } catch: { error in
            await DotoriToast.makeToast(text: error.localizedDescription, style: .error)
        }
    }
}
