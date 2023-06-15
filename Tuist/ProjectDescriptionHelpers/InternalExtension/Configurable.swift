import Foundation

protocol Configurable {
    func with(_ block: (inout Self) throws -> Void) rethrows -> Self
}

extension Configurable {
    @inlinable
    public func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}
