import AuthDomain
import MainFeature
import RootFeature
import SigninFeature
import SignupFeature
import RenewalPasswordFeature
import Swinject
import UIKit
import JwtStore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let container = Container()
    var assembler: Assembler!

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        assembler = Assembler([
            JwtStoreAssembly(),
            MainAssembly(),
            SigninAssembly(),
            SignupAssembly(),
            RenewalPasswordAssembly(),
            RootAssembly(),
            AuthDomainAssembly()
        ], container: AppDelegate.container)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) { }
}
