import AuthDomain
import Database
import HomeFeature
import IQKeyboardManagerSwift
import JwtStore
import KeyValueStore
import MainTabFeature
import MassageDomain
import MassageFeature
import MealDomain
import MusicFeature
import Networking
import NoticeFeature
import RenewalPasswordFeature
import RootFeature
import SelfStudyDomain
import SelfStudyFeature
import SigninFeature
import SignupFeature
import Swinject
import Timer
import UIKit
import UserDomain

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
            KeyValueStoreAssembly(),
            NetworkingAssembly(),
            TimerAssembly(),
            DatabaseAssembly(),
            HomeAssembly(),
            NoticeAssembly(),
            SelfStudyAssembly(),
            MassageAssembly(),
            MusicAssembly(),
            MainAssembly(),
            SigninAssembly(),
            SignupAssembly(),
            RenewalPasswordAssembly(),
            RootAssembly(),
            AuthDomainAssembly(),
            UserDomainAssembly(),
            SelfStudyDomainAssembly(),
            MassageDomainAssembly(),
            MealDomainAssembly()
        ], container: AppDelegate.container)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
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
    ) {}
}
