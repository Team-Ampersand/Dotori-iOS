public protocol StoreBindable {
    func bindState()
    func bindAction()
}

public extension StoreBindable {
    func bindState() {}
    func bindAction() {}
}
