import AuthDomainInterface
import BaseFeature
import DesignSystem
import DWebKit
import SignupFeatureInterface
import UIKit

struct SignupFactoryImpl: SignupFactory {
    func makeViewController(signinHandler: @escaping () -> Void) -> UIViewController {
        let url = "https://www.dotori-gsm.com/signup"

        return DWebViewController(
            urlString: url,
            detectHandler: signinHandler
        )
    }
}
