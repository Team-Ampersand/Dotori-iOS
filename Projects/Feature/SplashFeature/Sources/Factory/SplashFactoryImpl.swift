import AuthDomainInterface
import BaseFeature
import UIKit

final class SplashFactoryImpl: SplashFactory {
    private let checkIsLoggedInUseCase: any CheckIsLoggedInUseCase

    init(checkIsLoggedInUseCase: any CheckIsLoggedInUseCase) {
        self.checkIsLoggedInUseCase = checkIsLoggedInUseCase
    }

    func makeViewController() -> any StoredViewControllable {
        let store = SplashStore(checkIsLoggedInUseCase: checkIsLoggedInUseCase)
        return SplashViewController(store: store)
    }
}
