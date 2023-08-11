import Combine
import Foundation
import TimerInterface

/// Stub 테스트 더블 객체
class RepeatableTimerStub: RepeatableTimer {
    var repeatPublisherClosure: ((TimeInterval, RunLoop, RunLoop.Mode) -> AnyPublisher<Date, Never>) = { _, _, _ in
        Empty().eraseToAnyPublisher()
    }

    func repeatPublisher(
        every interval: TimeInterval,
        on runLoop: RunLoop,
        in mode: RunLoop.Mode
    ) -> AnyPublisher<Date, Never> {
        repeatPublisherClosure(interval, runLoop, mode)
    }
}
