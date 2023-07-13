import AuthDomainInterface
import Swinject
import TimerInterface

public final class HomeAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(HomeFactory.self) { resolver in
            HomeFactoryImpl(repeatableTimer: resolver.resolve(RepeatableTimer.self)!)
        }
    }
}
