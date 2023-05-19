import Combine
import Foundation

public protocol HasCancellableBag {
    var subscription: Set<AnyCancellable> { get }
}
