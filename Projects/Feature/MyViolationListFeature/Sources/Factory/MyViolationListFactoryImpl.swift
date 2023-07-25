import BaseFeature

struct MyViolationListFactoryImpl: MyViolationListFactory {
    func makeViewController() -> any StoredViewControllable {
        let store = MyViolationListStore()
        return MyViolationListViewController(store: store)
    }
}
