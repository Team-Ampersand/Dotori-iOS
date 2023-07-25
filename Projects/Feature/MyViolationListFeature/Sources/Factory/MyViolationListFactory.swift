import BaseFeature

public protocol MyViolationListFactory {
    func makeViewController() -> any StoredViewControllable
}
