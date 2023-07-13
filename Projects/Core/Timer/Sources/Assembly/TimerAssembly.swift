import Foundation
import Swinject
import TimerInterface

public final class TimerAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(RepeatableTimer.self) { _ in
            RepeatableTimerImpl()
        }
    }
}
