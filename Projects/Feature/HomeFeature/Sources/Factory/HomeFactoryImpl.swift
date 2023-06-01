import AuthDomainInterface
import Moordinator

struct HomeFactoryImpl: HomeFactory {
    private let loadJwtTokenUseCase: any LoadJwtTokenUseCase

    init(loadJwtTokenUseCase: any LoadJwtTokenUseCase) {
        self.loadJwtTokenUseCase = loadJwtTokenUseCase
    }

    func makeMoordinator() -> Moordinator {
        HomeMoordinator(loadJwtTokenUseCase: self.loadJwtTokenUseCase)
    }
}
