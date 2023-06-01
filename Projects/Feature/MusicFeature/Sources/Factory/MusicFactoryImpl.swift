import Moordinator

struct MusicFactoryImpl: MusicFactory {
    func makeMoordinator() -> Moordinator {
        MusicMoordinator()
    }
}
