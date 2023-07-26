import MassageDomainInterface
import Moordinator
import UserDomainInterface

struct MassageFactoryImpl: MassageFactory {
    private let fetchMassageRankListUseCase: any FetchMassageRankListUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase

    init(
        fetchMassageRankListUseCase: any FetchMassageRankListUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    ) {
        self.fetchMassageRankListUseCase = fetchMassageRankListUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
    }

    func makeMoordinator() -> Moordinator {
        let store = MassageStore(
            fetchMassageRankListUseCase: fetchMassageRankListUseCase,
            loadCurrentUserRoleUseCase: <#T##LoadCurrentUserRoleUseCase#>
        )
        let viewController = MassageViewController(store: store)
        return MassageMoordinator(massageViewController: viewController)
    }
}
