import BaseFeatureInterface
import Foundation
import Moordinator

public protocol HasStore: HasRouter {
    associatedtype Store: BaseStore
    var store: Store { get }
}

public extension HasStore {
    var router: any Router {
        store
    }
}
