import Inject
@testable import InputDialogFeature
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let store = InputDialogStore(inputType: .text) { _ in }
        let viewController = Inject.ViewControllerHost(
            InputDialogViewController(
                title: "안마 의자 인원 수정",
                placeholder: "5",
                store: store
            )
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
