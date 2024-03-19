import BaseFeatureInterface

public protocol YPImageFactory {
    func makeViewController() -> any RoutedViewControllable
}
