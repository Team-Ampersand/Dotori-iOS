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

    struct State {}
    enum Action {
        case signupButtonDidTap
        case renewalPasswordButtonDidTap
        case signin(String)
    }

    enum Mutation {}

    let stateSubject = CurrentValueSubject<State, Never>(State())

    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .signupButtonDidTap:
            route.send(DotoriRoutePath.signup)

        case .renewalPasswordButtonDidTap:
            route.send(DotoriRoutePath.renewalPassword)

        case let .signin(code):
            signin(code: code)

        default:
            return .none
        }
        return .none
    }

    func reduce(state: State, mutate: Mutation) -> State {}

    func signin(code: String) {
        let req = SigninRequestDTO(code: code)

        Task.catching {
            try await self.signinUseCase.execute(req: req)
            self.route.send(DotoriRoutePath.main)
        } catch: { error in
            await DotoriToast.makeToast(text: error.localizedDescription, style: .error)
        }
    }
}
