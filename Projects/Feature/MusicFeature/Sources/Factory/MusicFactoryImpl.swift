import Moordinator

struct MusicFactoryImpl: MusicFactory {
    func makeViewController() -> Moordinator {
        MusicMoordinator()
    }
}
