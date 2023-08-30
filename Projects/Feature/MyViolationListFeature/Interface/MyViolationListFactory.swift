import BaseFeatureInterface

public protocol MyViolationListFactory {
    func makeViewController() -> any RoutedViewControllable
}
