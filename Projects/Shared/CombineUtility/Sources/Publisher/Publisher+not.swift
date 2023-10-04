import Combine

public extension Publisher where Output == Bool {
    func not() -> Publishers.Map<Self, Bool> {
        self.map { !$0 }
    }
}
