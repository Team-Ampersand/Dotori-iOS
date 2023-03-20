import UIKit
import DWebKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = DWebViewController(
            urlString: "https://dotori-v2.vercel.app",
            tokenDTO: .init(
                accessToken: "",
                refreshToken: "",
                expiresAt: ""
            )
        )
        viewController.view.backgroundColor = .yellow
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
