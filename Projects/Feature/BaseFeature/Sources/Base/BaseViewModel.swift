import Combine
import Foundation
import Moordinator

public protocol BaseViewModel {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) -> Output
}
