import BaseFeature
import UIKit
import Moordinator

public protocol SignupFactory {
    func makeViewController() -> UIViewController
}
