import BaseFeature
import Combine
import Moordinator
import Store
import UserDomainInterface

final class ProfileImageStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>

    private let addProfileImageUseCase: any AddProfileImageUseCase
    private let editProfileImageUseCase: any EditProfileImageUseCase
    private let deleteProfileImageUseCase: any DeleteProfileImageUseCase

    init(
        addProfileImageUseCase: any AddProfileImageUseCase,
        editProfileImageUseCase: any EditProfileImageUseCase,
        deleteProfileImageUseCase: any DeleteProfileImageUseCase
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.addProfileImageUseCase = addProfileImageUseCase
        self.editProfileImageUseCase = editProfileImageUseCase
        self.deleteProfileImageUseCase = deleteProfileImageUseCase
    }

    struct State {
//        var violationList = [ViolationModel]()
    }

    enum Action {
        ///        case fetchMyViolationList
        case xmarkButtonDidTap
        case dimmedBackgroundDidTap
        case confirmButtonDidTap
    }

    enum Mutation {
//        case updateViolationList([ViolationModel])
    }
}

extension ProfileImageStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
//        case .fetchMyViolationList:
//            return SideEffect<[ViolationModel], Error>
//                .tryAsync { [fetchMyViolationListUseCase] in
//                    try await fetchMyViolationListUseCase()
//                }
//                .map(Mutation.updateViolationList)
//                .eraseToSideEffect()
//                .catchToNever()

        case .xmarkButtonDidTap, .dimmedBackgroundDidTap, .confirmButtonDidTap:
            route.send(DotoriRoutePath.dismiss)
        }
        return .none
    }
}

extension ProfileImageStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
//        case let .updateViolationList(violationList):
//            newState.violationList = violationList
        }
        return newState
    }
}
