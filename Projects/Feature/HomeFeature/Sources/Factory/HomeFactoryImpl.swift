import AuthDomainInterface
import Moordinator
import TimerInterface

struct HomeFactoryImpl: HomeFactory {
    private let repeatableTimer: any RepeatableTimer

    init(repeatableTimer: any RepeatableTimer) {
        self.repeatableTimer = repeatableTimer
    }

    func makeMoordinator() -> Moordinator {
        HomeMoordinator(repeatableTimer: repeatableTimer)
    }
}
