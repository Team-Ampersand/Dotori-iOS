import Combine

extension Publisher where Failure == Never {
    public func toAsyncStream(subscription: inout Set<AnyCancellable>) -> AsyncStream<Output> {
        AsyncStream { continuation in
            self.sink { output in
                continuation.yield(output)
            }
            .store(in: &subscription)
        }
    }
}
