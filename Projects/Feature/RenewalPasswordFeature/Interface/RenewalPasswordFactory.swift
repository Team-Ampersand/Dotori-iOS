import UIKit
import Moordinator

public protocol RenewalPasswordFactory {
    func makeViewController(router: any Router) -> UIViewController
}
