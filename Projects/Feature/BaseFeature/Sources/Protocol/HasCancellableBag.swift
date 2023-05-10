import Combine
import Foundation

public protocol HasCancellableBag {
    var bag: Set<AnyCancellable> { get }
}
