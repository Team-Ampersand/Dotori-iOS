import BaseFeature
import Combine
import DesignSystem
import Foundation
import Localization
import Moordinator
import Store
import UIKit
import UserDomainInterface
import YPImagePicker

final class ImagePickerStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>

    init() {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
    }

    struct State {}

    enum Action {}

    enum Mutation {}
}

extension ImagePickerStore {
    func reduce(state: State, mutate: Mutation) -> State {}
}

extension ImagePickerStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {}
}
