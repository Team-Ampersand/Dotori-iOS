import Combine
import Inject
import UIKit
@testable import HomeFeature
@testable import TimerTesting

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let repeatableTimerStub = RepeatableTimerStub()
        repeatableTimerStub.repeatPublisherClosure = { _, _, _ in
            Timer.publish(every: 1, on: .main, in: .default)
                .autoconnect()
                .eraseToAnyPublisher()
        }
        let viewController = Inject.ViewControllerHost(
            UINavigationController(
                rootViewController: HomeViewController(
                    store: .init(repeatableTimer: repeatableTimerStub)
                )
            )
        )
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
