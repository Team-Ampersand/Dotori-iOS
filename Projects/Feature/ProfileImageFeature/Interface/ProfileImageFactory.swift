import BaseFeatureInterface

public protocol ProfileImageFactory {
    func makeViewController() -> any RoutedViewControllable
}
