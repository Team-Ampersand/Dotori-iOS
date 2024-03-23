import BaseFeature
import BaseFeatureInterface
import Combine
import InputDialogFeatureInterface
import Moordinator
import Store

final class InputDialogStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let confirmAction: (String) async -> Void

    init(
        inputType: DialogInputType,
        confirmAction: @escaping (String) async -> Void
    ) {
        self.initialState = .init(inputType: inputType)
        self.stateSubject = .init(initialState)
        self.confirmAction = confirmAction
    }

    struct State {
        var inputType: DialogInputType
        var inputText = ""
        var isLoading = false
    }

    enum Action {
        case updateInputText(String)
        case dimmedBackgroundViewDidTap
        case cancelButtonDidTap
        case confirmButtonDidTap
    }

    enum Mutation {
        case updateInputText(String)
        case updateIsLoading(Bool)
    }
}

extension InputDialogStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case let .updateInputText(inputText):
            return self.updateInputText(inputText: inputText)

        case .dimmedBackgroundViewDidTap, .cancelButtonDidTap:
            route.send(DotoriRoutePath.dismiss())

        case .confirmButtonDidTap:
            let confirmEffect = SideEffect<Void, Never>
                .async { [confirmAction, inputText = currentState.inputText] in
                    await confirmAction(inputText)
                }
                .handleEvents(receiveOutput: { [route] in
                    route.send(DotoriRoutePath.dismiss())
                })
                .flatMap { SideEffect<Mutation, Never>.none }
                .eraseToSideEffect()
            return .merge(
                confirmEffect,
                .just(.updateIsLoading(true))
            )
        }
        return .none
    }
}

extension InputDialogStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateInputText(inputText):
            newState.inputText = inputText

        case let .updateIsLoading(isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}

// MARK: - Mutate
private extension InputDialogStore {
    func updateInputText(inputText: String) -> SideEffect<Mutation, Never> {
        return .just(.updateInputText(inputText))
    }
}
