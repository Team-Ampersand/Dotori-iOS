import Swinject
import HomeFeature
import MassageFeature
import MusicFeature
import NoticeFeature
import SelfStudyFeature

public final class MainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MainFactory.self) { resolver in
            MainFactoryImpl(
                homeFactory: resolver.resolve(HomeFactory.self)!,
                noticeFactory: resolver.resolve(NoticeFactory.self)!,
                selfStudyFactory: resolver.resolve(SelfStudyFactory.self)!,
                massageFactory: resolver.resolve(MassageFactory.self)!,
                musicFactory: resolver.resolve(MusicFactory.self)!
            )
        }
    }
}
