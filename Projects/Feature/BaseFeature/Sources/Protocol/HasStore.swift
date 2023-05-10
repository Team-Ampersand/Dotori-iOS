import Foundation

public protocol HasStore {
    associatedtype Store: BaseStore
    var store: Store { get }
}
