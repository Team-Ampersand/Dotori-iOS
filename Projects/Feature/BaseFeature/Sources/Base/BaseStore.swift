import Combine
import Foundation
import Moordinator

public protocol BaseStore {
    associatedtype State
    associatedtype Action

    var stateSubject: CurrentValueSubject<State, Never> { get }
    var state: AnyPublisher<State, Never> { get }
    var bag: Set<AnyCancellable> { get }

    func process(_ action: Action)
}

public extension BaseStore {
    var state: AnyPublisher<State, Never> {
        stateSubject.eraseToAnyPublisher()
    }
}
