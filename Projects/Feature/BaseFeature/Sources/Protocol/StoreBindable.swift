public protocol StoreBindable {
    func bindState()
    func bindAction()
}

extension StoreBindable {
    func bindState() {}
    func bindAction() {}
}
