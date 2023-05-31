import Moordinator

public struct HomeFactoryImpl: HomeFactory {
    public func makeMoordinator() -> Moordinator {
        HomeMoordinator()
    }
}
