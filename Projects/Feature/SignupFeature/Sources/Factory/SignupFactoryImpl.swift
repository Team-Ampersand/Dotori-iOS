import AuthDomainInterface
import BaseFeature
import DesignSystem
import DWebKit
import UIKit

struct SignupFactoryImpl: SignupFactory {
    func makeViewController() -> UIViewController {
        let url = "https://www.dotori-gsm.com/signup"

        return DWebViewController(
            urlString: url
        )
    }
}
