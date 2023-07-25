import Moordinator
import SelfStudyDomainInterface
import UserDomainInterface

struct SelfStudyFactoryImpl: SelfStudyFactory {
    private let fetchSelfStudyRankListUseCase: any FetchSelfStudyRankListUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    private let checkSelfStudyMemberUseCase: any CheckSelfStudyMemberUseCase

    init(
        fetchSelfStudyRankListUseCase: any FetchSelfStudyRankListUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase,
        checkSelfStudyMemberUseCase: any CheckSelfStudyMemberUseCase
    ) {
        self.fetchSelfStudyRankListUseCase = fetchSelfStudyRankListUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
        self.checkSelfStudyMemberUseCase = checkSelfStudyMemberUseCase
    }

    func makeMoordinator() -> Moordinator {
        let store = SelfStudyStore(
            fetchSelfStudyRankListUseCase: fetchSelfStudyRankListUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase,
            checkSelfStudyMemberUseCase: checkSelfStudyMemberUseCase
        )
        let viewController = SelfStudyViewController(store: store)
        return SelfStudyMoordinator(selfStudyViewController: viewController)
    }
}
