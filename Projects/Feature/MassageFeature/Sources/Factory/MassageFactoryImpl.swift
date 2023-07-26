import MassageDomainInterface
import Moordinator

struct MassageFactoryImpl: MassageFactory {
    private let fetchMassageRankListUseCase: any FetchMassageRankListUseCase

    init(fetchMassageRankListUseCase: any FetchMassageRankListUseCase) {
        self.fetchMassageRankListUseCase = fetchMassageRankListUseCase
    }

    func makeMoordinator() -> Moordinator {
        let store = MassageStore(fetchMassageRankListUseCase: fetchMassageRankListUseCase)
        let viewController = MassageViewController(store: store)
        return MassageMoordinator(massageViewController: viewController)
    }
}
