import Combine
import Foundation

public extension AnyPublisher {
    init(
        _ factory: @escaping (Publishers.Create<Output, Failure>.Subscriber) -> Cancellable
    ) {
        self = Publishers.Create(factory: factory).eraseToAnyPublisher()
    }

    static func create(
        _ factory: @escaping (Publishers.Create<Output, Failure>.Subscriber) -> Cancellable
    ) -> AnyPublisher<Output, Failure> {
        AnyPublisher(factory)
    }
}

// MARK: - 'Create' Publisher
public extension Publishers {
    struct Create<Output, Failure: Swift.Error>: Publisher {
        private let factory: (Create.Subscriber) -> Cancellable

        public init(factory: @escaping (Create.Subscriber) -> Cancellable) {
            self.factory = factory
        }

        public func receive<S: Combine.Subscriber>(subscriber: S) where Failure == S.Failure, Output == S.Input {
            subscriber.receive(subscription: Create.Subscription(factory: factory, downstream: subscriber))
        }
    }
}

// MARK: - Create's Subscription
private extension Publishers.Create {
    class Subscription<Downstream: Combine.Subscriber>: Combine.Subscription
        where Output == Downstream.Input, Failure == Downstream.Failure {
        private let buffer: DemandBuffer<Downstream>
        private var cancelable: Cancellable?

        init(
            factory: @escaping (Subscriber) -> Cancellable,
            downstream: Downstream
        ) {
            self.buffer = DemandBuffer(subscriber: downstream)

            let subscriber = Subscriber(
                onValue: { [weak self] in _ = self?.buffer.buffer(value: $0) },
                onCompletion: { [weak self] in self?.buffer.complete(completion: $0) }
            )

            self.cancelable = factory(subscriber)
        }

        func request(_ demand: Subscribers.Demand) {
            _ = self.buffer.demand(demand)
        }

        func cancel() {
            self.cancelable?.cancel()
        }
    }
}

// MARK: - Create's Subscriber
public extension Publishers.Create {
    struct Subscriber {
        private let onValue: (Output) -> Void
        private let onCompletion: (Subscribers.Completion<Failure>) -> Void

        fileprivate init(
            onValue: @escaping (Output) -> Void,
            onCompletion: @escaping (Subscribers.Completion<Failure>) -> Void
        ) {
            self.onValue = onValue
            self.onCompletion = onCompletion
        }

        public func send(_ input: Output) {
            onValue(input)
        }

        public func send(completion: Subscribers.Completion<Failure>) {
            onCompletion(completion)
        }
    }
}
