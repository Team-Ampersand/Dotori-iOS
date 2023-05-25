import Moordinator

public struct MainFactoryImpl: MainFactory {
    public func makeMoordinator() -> Moordinator {
        MainTabMoordinator()
    }
}
