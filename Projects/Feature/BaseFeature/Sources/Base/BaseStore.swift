import Combine
import Foundation
import Moordinator

public protocol BaseStore: Router, HasCancellableBag {
    associatedtype State
    associatedtype Action

    var stateSubject: CurrentValueSubject<State, Never> { get }
    var currentState: State { get }
    var state: AnyPublisher<State, Never> { get }

    func process(_ action: Action)
}

public extension BaseStore {
    var currentState: State {
        stateSubject.value
    }

    var state: AnyPublisher<State, Never> {
        stateSubject.eraseToAnyPublisher()
    }
}
