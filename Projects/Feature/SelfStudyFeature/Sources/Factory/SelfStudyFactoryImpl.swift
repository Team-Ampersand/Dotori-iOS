import FilterSelfStudyFeatureInterface
import Moordinator
import SelfStudyDomainInterface
import UserDomainInterface

struct SelfStudyFactoryImpl: SelfStudyFactory {
    private let fetchSelfStudyRankListUseCase: any FetchSelfStudyRankListUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    private let checkSelfStudyMemberUseCase: any CheckSelfStudyMemberUseCase
    private let filterSelfStudyFactory: any FilterSelfStudyFactory

    init(
        fetchSelfStudyRankListUseCase: any FetchSelfStudyRankListUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase,
        checkSelfStudyMemberUseCase: any CheckSelfStudyMemberUseCase,
        filterSelfStudyFactory: any FilterSelfStudyFactory
    ) {
        self.fetchSelfStudyRankListUseCase = fetchSelfStudyRankListUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
        self.checkSelfStudyMemberUseCase = checkSelfStudyMemberUseCase
        self.filterSelfStudyFactory = filterSelfStudyFactory
    }

    func makeMoordinator() -> Moordinator {
        let store = SelfStudyStore(
            fetchSelfStudyRankListUseCase: fetchSelfStudyRankListUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase,
            checkSelfStudyMemberUseCase: checkSelfStudyMemberUseCase
        )
        let viewController = SelfStudyViewController(store: store)
        return SelfStudyMoordinator(
            selfStudyViewController: viewController,
            filterSelfStudyFactory: filterSelfStudyFactory
        )
    }
}
