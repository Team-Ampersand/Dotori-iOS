import BaseFeature
import Combine
import DesignSystem
import Foundation
import Localization
import Moordinator
import Store
import UserDomainInterface
import YPImagePicker

final class ProfileImageStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let fetchProfileImageUseCase: any FetchProfileImageUseCase
    private let addProfileImageUseCase: any AddProfileImageUseCase
    private let deleteProfileImageUseCase: any DeleteProfileImageUseCase

    init(
        fetchProfileImageUseCase: any FetchProfileImageUseCase,
        addProfileImageUseCase: any AddProfileImageUseCase,
        deleteProfileImageUseCase: any DeleteProfileImageUseCase
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.fetchProfileImageUseCase = fetchProfileImageUseCase
        self.addProfileImageUseCase = addProfileImageUseCase
        self.deleteProfileImageUseCase = deleteProfileImageUseCase
    }

    struct State {
        // MARK: - For Fetched ProfileImage
        var fetchedCurrentProfileImageURL: String?

        // MARK: - For Selected ProfileImage
        var selectedProfileImage: Data?
        var isLoading = false
    }

    enum Action {
        case fetchProfileImage
        case xmarkButtonDidTap
        case addImageButtonDidTap
        case deleteProfileImageButtonDidTap
        case dimmedBackgroundDidTap
        case confirmButtonDidTap
        case addProfileImage(Data)
    }

    enum Mutation {
        case fetchProfileImage(String)
        case updateIsLoading(Bool)
        case addProfileImage(Data)
    }
}

extension ProfileImageStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .fetchProfileImage:
            return SideEffect<String, Error>
                .tryAsync { [fetchProfileImageUseCase] in
                    try await fetchProfileImageUseCase()
                }
                .map(Mutation.fetchProfileImage)
                .eraseToSideEffect()
                .catchToNever()
        case .addImageButtonDidTap:
            let path = DotoriRoutePath.imagePicker { [weak self] profileImage in
                let dismissPath = DotoriRoutePath.dismiss {
                    self?.send(Action.addProfileImage(profileImage))
                }
                self?.route.send(dismissPath)
            }
            route.send(path)
        case .xmarkButtonDidTap, .dimmedBackgroundDidTap:
            route.send(DotoriRoutePath.dismiss())
        case .confirmButtonDidTap:
            return confirmButtonDidTap()
        case let .addProfileImage(profileImage):
            return .just(Mutation.addProfileImage(profileImage))
        case .deleteProfileImageButtonDidTap:
            return deleteProfileImageButtonDidTap()
        }
        return .none
    }
}

extension ProfileImageStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .fetchProfileImage(fetchedProfileImage):
            newState.fetchedCurrentProfileImageURL = fetchedProfileImage
        case let .updateIsLoading(isLoading):
            newState.isLoading = isLoading
        case let .addProfileImage(selectedProfileImage):
            newState.selectedProfileImage = selectedProfileImage
        }
        return newState
    }
}

extension ProfileImageStore {
    func confirmButtonDidTap() -> SideEffect<Mutation, Never> {
        let addProfileImageEffect = SideEffect<Void, Error>
            .tryAsync { [profileImage = currentState.selectedProfileImage, addProfileImageUseCase] in
                if let profileImage {
                    try await addProfileImageUseCase(profileImage: profileImage)
                }
            }
            .handleEvents(receiveOutput: { [route] _ in
                DotoriToast.makeToast(text: L10n.ProfileImage.successToAddProfileImageTitle, style: .success)
                route.send(DotoriRoutePath.dismiss())
            })
            .eraseToSideEffect()
            .catchMap { error in
                DotoriToast.makeToast(text: error.localizedDescription, style: .error)
            }
            .flatMap { SideEffect<Mutation, Never>.none }
            .eraseToSideEffect()
        return self.makeLoadingSideEffect(addProfileImageEffect)
    }

    func deleteProfileImageButtonDidTap() -> SideEffect<Mutation, Never> {
        let deleteProfileImageEffect = SideEffect<Void, Error>
            .tryAsync { [deleteProfileImageUseCase] in
                try await deleteProfileImageUseCase()
            }
            .handleEvents(receiveOutput: { [route] _ in
                DotoriToast.makeToast(text: L10n.ProfileImage.successToDeleteProfileImageTitle, style: .success)
                route.send(DotoriRoutePath.dismiss())
            })
            .eraseToSideEffect()
            .catchMap { error in
                DotoriToast.makeToast(text: error.localizedDescription, style: .error)
            }
            .flatMap { SideEffect<Mutation, Never>.none }
            .eraseToSideEffect()
        return self.makeLoadingSideEffect(deleteProfileImageEffect)
    }
}

// MARK: - Reusable
private extension ProfileImageStore {
    func makeLoadingSideEffect(
        _ publisher: SideEffect<Mutation, Never>
    ) -> SideEffect<Mutation, Never> {
        let startLoadingPublisher = SideEffect<Mutation, Never>
            .just(Mutation.updateIsLoading(true))
        let endLoadingPublisher = SideEffect<Mutation, Never>
            .just(Mutation.updateIsLoading(false))
        return startLoadingPublisher
            .append(publisher)
            .append(endLoadingPublisher)
            .eraseToSideEffect()
    }
}
