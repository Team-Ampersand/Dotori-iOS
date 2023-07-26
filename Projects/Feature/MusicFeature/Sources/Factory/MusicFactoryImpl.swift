import Moordinator

struct MusicFactoryImpl: MusicFactory {
    func makeMoordinator() -> Moordinator {
        let store = MusicStore()
        let viewController = MusicViewController(store: store)
        return MusicMoordinator(musicViewController: viewController)
    }
}
