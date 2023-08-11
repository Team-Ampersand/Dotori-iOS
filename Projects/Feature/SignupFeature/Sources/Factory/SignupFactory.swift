import BaseFeature
import Moordinator
import UIKit

public protocol SignupFactory {
    func makeViewController(signinHandler: @escaping () -> Void) -> UIViewController
}
