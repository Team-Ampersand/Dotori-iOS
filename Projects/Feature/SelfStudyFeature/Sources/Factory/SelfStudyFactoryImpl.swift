import Moordinator
import SelfStudyDomainInterface
import UserDomainInterface

struct SelfStudyFactoryImpl: SelfStudyFactory {
    private let fetchSelfStudyRankListUseCase: any FetchSelfStudyRankListUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase

    init(
        fetchSelfStudyRankListUseCase: any FetchSelfStudyRankListUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    ) {
        self.fetchSelfStudyRankListUseCase = fetchSelfStudyRankListUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
    }

    func makeMoordinator() -> Moordinator {
        let store = SelfStudyStore(
            fetchSelfStudyRankListUseCase: fetchSelfStudyRankListUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
        let viewController = SelfStudyViewController(store: store)
        return SelfStudyMoordinator(selfStudyViewController: viewController)
    }
}
