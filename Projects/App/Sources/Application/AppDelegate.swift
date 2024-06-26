import AuthDomain
import ConfirmationDialogFeature
import Database
import DetailNoticeFeature
import FilterSelfStudyFeature
import HomeFeature
import ImagePickerFeature
import InputDialogFeature
import IQKeyboardManagerSwift
import JwtStore
import KeyValueStore
import MainTabFeature
import MassageDomain
import MassageFeature
import MealDomain
import MusicDomain
import MusicFeature
import MyViolationListFeature
import Networking
import NoticeDomain
import NoticeFeature
import ProfileImageFeature
import ProposeMusicFeature
import RenewalPasswordFeature
import RootFeature
import SelfStudyDomain
import SelfStudyFeature
import SigninFeature
import SignupFeature
import SplashFeature
import Swinject
import Timer
import UIKit
import UserDomain
import ViolationDomain

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
            SplashAssembly(),
            HomeAssembly(),
            InputDialogAssembly(),
            MyViolationListAssembly(),
            ProfileImageAssembly(),
            NoticeAssembly(),
            DetailNoticeAssembly(),
            SelfStudyAssembly(),
            FilterSelfStudyAssembly(),
            ConfirmationDialogAssembly(),
            MassageAssembly(),
            ProposeMusicAssembly(),
            MusicAssembly(),
            MainAssembly(),
            SigninAssembly(),
            SignupAssembly(),
            RenewalPasswordAssembly(),
            RootAssembly(),
            MusicDomainAssembly(),
            AuthDomainAssembly(),
            UserDomainAssembly(),
            SelfStudyDomainAssembly(),
            MassageDomainAssembly(),
            ViolationDomainAssembly(),
            MealDomainAssembly(),
            NoticeDomainAssembly(),
            ImagePickerAssembly()
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
