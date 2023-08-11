import Combine
import Foundation

class DemandBuffer<S: Subscriber> {
    private let lock = NSRecursiveLock()
    private var buffer = [S.Input]()
    private let subscriber: S
    private var completion: Subscribers.Completion<S.Failure>?
    private var demandState = Demand()

    init(subscriber: S) {
        self.subscriber = subscriber
    }

    func buffer(value: S.Input) -> Subscribers.Demand {
        precondition(
            self.completion == nil,
            "How could a completed publisher sent values?! Beats me 🤷‍♂️"
        )
        lock.lock()
        defer { lock.unlock() }

        switch demandState.requested {
        case .unlimited:
            return subscriber.receive(value)
        default:
            buffer.append(value)
            return flush()
        }
    }

    func complete(completion: Subscribers.Completion<S.Failure>) {
        precondition(
            self.completion == nil,
            "Completion have already occured, which is quite awkward 🥺"
        )

        self.completion = completion
        _ = flush()
    }

    func demand(_ demand: Subscribers.Demand) -> Subscribers.Demand {
        flush(adding: demand)
    }

    private func flush(adding newDemand: Subscribers.Demand? = nil) -> Subscribers.Demand {
        lock.lock()
        defer { lock.unlock() }

        if let newDemand {
            demandState.requested += newDemand
        }

        guard demandState.requested > 0 || newDemand == Subscribers.Demand.none else { return .none }

        while !buffer.isEmpty && demandState.processed < demandState.requested {
            demandState.requested += subscriber.receive(buffer.remove(at: 0))
            demandState.processed += 1
        }

        if let completion {
            buffer = []
            demandState = .init()
            self.completion = nil
            subscriber.receive(completion: completion)
            return .none
        }

        let sentDemand = demandState.requested - demandState.sent
        demandState.sent += sentDemand
        return sentDemand
    }
}

private extension DemandBuffer {
    struct Demand {
        var processed: Subscribers.Demand = .none
        var requested: Subscribers.Demand = .none
        var sent: Subscribers.Demand = .none
    }
}

extension Subscription {
    func requestIfNeeded(_ demand: Subscribers.Demand) {
        guard demand > .none else { return }
        request(demand)
    }
}

extension Optional where Wrapped == Subscription {
    mutating func kill() {
        self?.cancel()
        self = nil
    }
}
