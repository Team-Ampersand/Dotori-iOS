import Combine

public extension Publisher {
    func sink<Object: AnyObject>(
        with object: Object,
        receiveCompletion: @escaping ((Object, Subscribers.Completion<Failure>) -> Void) = { _, _ in },
        receiveValue: @escaping ((Object, Output) -> Void) = { _, _ in }
    ) -> AnyCancellable {
        self.sink { [weak object] completion in
            guard let object else { return }
            receiveCompletion(object, completion)
        } receiveValue: { [weak object] value in
            guard let object else { return }
            receiveValue(object, value)
        }
    }
}

public extension Publisher {
    func sink(to subject: any Subject<Output, Failure>) -> AnyCancellable {
        self.sink { completion in
            subject.send(completion: completion)
        } receiveValue: { output in
            subject.send(output)
        }
    }
}
