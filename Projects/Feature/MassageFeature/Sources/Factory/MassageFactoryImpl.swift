import Moordinator

struct MassageFactoryImpl: MassageFactory {
    func makeMoordinator() -> Moordinator {
        MassageMoordinator()
    }
}
