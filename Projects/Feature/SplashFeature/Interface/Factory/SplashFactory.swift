import BaseFeatureInterface
import UIKit

public protocol SplashFactory {
    func makeViewController() -> any RoutedViewControllable
}
