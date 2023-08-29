import BaseFeature
import MyViolationListFeatureInterface
import ViolationDomainInterface

struct MyViolationListFactoryImpl: MyViolationListFactory {
    private let fetchMyViolationListUseCase: any FetchMyViolationListUseCase

    init(fetchMyViolationListUseCase: any FetchMyViolationListUseCase) {
        self.fetchMyViolationListUseCase = fetchMyViolationListUseCase
    }

    func makeViewController() -> any RoutedViewControllable {
        let store = MyViolationListStore(
            fetchMyViolationListUseCase: fetchMyViolationListUseCase
        )
        return MyViolationListViewController(store: store)
    }
}
