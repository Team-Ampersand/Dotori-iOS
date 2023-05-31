import Moordinator

struct MainFactoryImpl: MainFactory {
    func makeMoordinator() -> Moordinator {
        MainTabMoordinator()
    }
}
