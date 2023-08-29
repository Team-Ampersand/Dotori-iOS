import BaseFeatureInterface
import UIKit

public protocol ProposeMusicFactory {
    func makeViewController() -> any RoutedViewControllable
}
