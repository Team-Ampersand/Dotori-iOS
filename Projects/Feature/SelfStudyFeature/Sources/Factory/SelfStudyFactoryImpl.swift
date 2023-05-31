import Moordinator

struct SelfStudyFactoryImpl: SelfStudyFactory {
    func makeMoordinator() -> Moordinator {
        SelfStudyMoordinator()
    }
}
