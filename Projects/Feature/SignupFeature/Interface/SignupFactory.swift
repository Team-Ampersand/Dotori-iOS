import Moordinator
import UIKit

public protocol SignupFactory {
    func makeViewController(router: any Router) -> UIViewController
}
