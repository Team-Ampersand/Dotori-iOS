import BaseFeature
import Moordinator
import UIKit

public protocol RenewalPasswordFactory {
    func makeViewController() -> UIViewController
}
