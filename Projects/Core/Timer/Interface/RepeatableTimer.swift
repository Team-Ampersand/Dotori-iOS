import Combine
import Foundation

public protocol RepeatableTimer {
    func repeatPublisher(
        every interval: TimeInterval,
        on runLoop: RunLoop,
        in mode: RunLoop.Mode
    ) -> AnyPublisher<Date, Never>
}

public extension RepeatableTimer {
    func repeatPublisher(
        every interval: TimeInterval,
        on runLoop: RunLoop = .main,
        in mode: RunLoop.Mode = .default
    ) -> AnyPublisher<Date, Never> {
        self.repeatPublisher(every: interval, on: runLoop, in: mode)
    }
}
