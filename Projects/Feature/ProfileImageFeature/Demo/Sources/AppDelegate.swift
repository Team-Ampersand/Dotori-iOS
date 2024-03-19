import Inject
@testable import ProfileImageFeature
import UIKit
@testable import UserDomainTesting

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let fetchProfileImageUseCase = FetchProfileImageUseCaseSpy()
        let addProfileImageUseCase = AddProfileImageUseCaseSpy()
        let deleteProfileImageUseCase = DeleteProfileImageUseCaseSpy()

        let store = ProfileImageStore(
            fetchProfileImageUseCase: fetchProfileImageUseCase,
            addProfileImageUseCase: addProfileImageUseCase,
            deleteProfileImageUseCase: deleteProfileImageUseCase
        )

        let viewController = Inject.ViewControllerHost(
            ProfileImageViewController(store: store)
        )

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }

    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}
