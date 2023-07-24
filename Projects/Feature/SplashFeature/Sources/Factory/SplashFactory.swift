import BaseFeature
import UIKit

public protocol SplashFactory {
    func makeViewController() -> any StoredViewControllable
}
