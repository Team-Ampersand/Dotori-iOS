import AuthDomainInterface
import SigninFeatureInterface
import Moordinator

struct SigninFactoryImpl: SigninFactory {
    private let signinUseCase: any SigninUseCase

    init(signinUseCase: any SigninUseCase) {
        self.signinUseCase = signinUseCase
    }

    func makeMoordinator() -> Moordinator {
        let signinRouter = SigninRouter()
        let signinStore = SigninStore(
            router: signinRouter,
            signinUseCase: self.signinUseCase
        )
        let signinViewController = SigninViewController(store: signinStore)
        return SigninMoordinator(
            router: signinRouter,
            signinViewController: signinViewController
        )
    }
}
