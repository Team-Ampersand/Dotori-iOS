import Moordinator

struct SelfStudyFactoryImpl: SelfStudyFactory {
    func makeMoordinator() -> Moordinator {
        let store = SelfStudyStore()
        let viewController = SelfStudyViewController(store: store)
        return SelfStudyMoordinator(selfStudyViewController: viewController)
    }
}
