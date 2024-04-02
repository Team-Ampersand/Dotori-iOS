import Combine
import Foundation

public extension Publisher {    
    func catchToNever() -> Publishers.Catch<Self, Empty<Self.Output, Never>> {
        self.catch { _ in Empty(completeImmediately: true) }
    }
}
