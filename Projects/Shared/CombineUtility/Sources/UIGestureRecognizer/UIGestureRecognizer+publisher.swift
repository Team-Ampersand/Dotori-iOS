import Combine
import UIKit

public extension UIView {
    func publisher<G: UIGestureRecognizer>(gesture gestureRecognizer: G) -> UIGestureRecognizer.Publisher<G> {
        UIGestureRecognizer.Publisher(gestureRecognizer: gestureRecognizer, view: self)
    }

    func tapGesturePublisher() -> AnyPublisher<UIGestureRecognizer, Never> {
        self.publisher(gesture: UITapGestureRecognizer())
            .eraseToAnyPublisher()
    }
}

extension UIGestureRecognizer {
    public struct Publisher<G>: Combine.Publisher where G: UIGestureRecognizer {
        public typealias Output = G
        public typealias Failure = Never

        let gestureRecognizer: G
        let view: UIView

        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            subscriber.receive(
                subscription: Subscription(subscriber: subscriber, gestureRecognizer: gestureRecognizer, on: view)
            )
        }
    }

    final class Subscription<G: UIGestureRecognizer, S: Subscriber>:
        NSObject,
        Combine.Subscription,
        UIGestureRecognizerDelegate
        where S.Input == G, S.Failure == Never {

        var subscriber: S?
        let gestureRecognizer: G
        let view: UIView

        init(subscriber: S, gestureRecognizer: G, on view: UIView) {
            self.subscriber = subscriber
            self.gestureRecognizer = gestureRecognizer
            self.view = view
            super.init()
            gestureRecognizer.addTarget(self, action: #selector(handle))
            gestureRecognizer.delegate = self
            view.addGestureRecognizer(gestureRecognizer)
        }

        @objc private func handle(_ gesture: UIGestureRecognizer) {
            _ = subscriber?.receive(gestureRecognizer)
        }

        func cancel() {
            view.removeGestureRecognizer(gestureRecognizer)
        }

        func request(_ demand: Subscribers.Demand) { }

        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            guard touch.view == self.view else {
                return false
            }
            return true
        }
    }
}
