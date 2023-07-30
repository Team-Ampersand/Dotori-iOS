import BaseFeatureInterface
import Foundation
import Moordinator

public protocol HasStore: HasRouter {
    associatedtype Store: BaseStore
    var store: Store { get }
}

extension HasStore {
    public var router: any Router {
        store
    }
}
