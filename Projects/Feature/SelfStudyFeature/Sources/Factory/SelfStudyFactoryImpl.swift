import Moordinator
import SelfStudyDomainInterface

struct SelfStudyFactoryImpl: SelfStudyFactory {
    private let fetchSelfStudyRankListUseCase: any FetchSelfStudyRankListUseCase

    init(fetchSelfStudyRankListUseCase: any FetchSelfStudyRankListUseCase) {
        self.fetchSelfStudyRankListUseCase = fetchSelfStudyRankListUseCase
    }

    func makeMoordinator() -> Moordinator {
        let store = SelfStudyStore(fetchSelfStudyRankListUseCase: fetchSelfStudyRankListUseCase)
        let viewController = SelfStudyViewController(store: store)
        return SelfStudyMoordinator(selfStudyViewController: viewController)
    }
}
