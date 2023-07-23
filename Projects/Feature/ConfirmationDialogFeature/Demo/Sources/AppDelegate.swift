import Inject
import UIKit
@testable import ConfirmationDialogFeature

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let store = ConfirmationDialogStore {}
        let viewController = Inject.ViewControllerHost(
            ConfirmationDialogViewController(
                title: "제목",
                description: "내용내용",
                store: store
            )
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
