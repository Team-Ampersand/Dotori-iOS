import BaseFeature
import Combine
import Moordinator
import Store

final class FilterSelfStudyStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let confirmAction: (
        _ name: String?,
        _ grade: Int?,
        _ `class`: Int?,
        _ gender: String?
    ) -> Void

    init(
        confirmAction: @escaping (
            _ name: String?,
            _ grade: Int?,
            _ `class`: Int?,
            _ gender: String?
        ) -> Void
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.confirmAction = confirmAction
    }

    struct State {
        var name: String?
        var grade: Int?
        var `class`: Int?
        var gender: FilterGenderType?
    }
    enum Action {
        case updateName(String?)
        case updateGrade(Int?)
        case updateClass(Int?)
        case updateGender(Int?)
        case confirmAction
        case resetButtonDidTap
        case dimmedBackgroundDidTap
    }
    enum Mutation {
        case updateName(String?)
        case updateGrade(Int?)
        case updateClass(Int?)
        case updateGender(FilterGenderType?)
    }
}

extension FilterSelfStudyStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case let .updateName(name):
            return .just(.updateName(name))

        case let .updateGrade(grade):
            let update = Mutation.updateGrade(grade.map { $0 + 1 })
            return .just(update)

        case let .updateClass(`class`):
            let update = Mutation.updateClass(`class`.map { $0 + 1 })
            return .just(update)

        case let .updateGender(genderIndex):
            let filter: FilterGenderType?
            if let genderIndex {
                filter = FilterGenderType(index: genderIndex)
            } else {
                filter = nil
            }
            let update = Mutation.updateGender(filter)
            return .just(update)

        case .confirmAction:
            confirmAction(
                currentState.name,
                currentState.grade,
                currentState.class,
                currentState.gender?.rawValue
            )
            route.send(DotoriRoutePath.dismiss)

        case .resetButtonDidTap:
            return .merge(
                .just(.updateName(nil)),
                .just(.updateGrade(nil)),
                .just(.updateClass(nil)),
                .just(.updateGender(nil))
            )

        case .dimmedBackgroundDidTap:
            route.send(DotoriRoutePath.dismiss)
        }
        return .none
    }
}

extension FilterSelfStudyStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateName(name):
            newState.name = name

        case let .updateGrade(grade):
            newState.grade = grade

        case let .updateClass(`class`):
            newState.class = `class`

        case let .updateGender(gender):
            newState.gender = gender
        }
        return newState
    }
}
