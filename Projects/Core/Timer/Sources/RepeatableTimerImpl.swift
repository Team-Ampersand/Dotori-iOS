import Combine
import Foundation
import TimerInterface

struct RepeatableTimerImpl: RepeatableTimer {
    func repeatPublisher(
        every interval: TimeInterval,
        on runLoop: RunLoop,
        in mode: RunLoop.Mode
    ) -> AnyPublisher<Date, Never> {
        Timer.publish(every: interval, on: runLoop, in: mode)
            .autoconnect()
            .eraseToAnyPublisher()
    }
}
