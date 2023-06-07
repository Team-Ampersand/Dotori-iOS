import AuthDomainInterface
import DWebKit
import Moordinator
import UIKit

struct RenewalPasswordFactoryImpl: RenewalPasswordFactory {
    func makeViewController() -> UIViewController {
        let url = "https://www.dotori-gsm.com/changePasswd"

        return DWebViewController(
            urlString: url
        )
    }
}
