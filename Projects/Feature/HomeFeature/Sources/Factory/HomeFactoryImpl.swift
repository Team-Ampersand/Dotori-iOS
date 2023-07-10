import AuthDomainInterface
import Moordinator

struct HomeFactoryImpl: HomeFactory {
    func makeMoordinator() -> Moordinator {
        HomeMoordinator()
    }
}
