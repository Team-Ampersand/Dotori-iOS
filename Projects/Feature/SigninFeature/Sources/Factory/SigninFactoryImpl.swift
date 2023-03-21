import AuthDomainInterface
import SigninFeatureInterface
import SignupFeatureInterface
import Moordinator

struct SigninFactoryImpl: SigninFactory {
    private let signinUseCase: any SigninUseCase
    private let signupFactory: any SignupFactory

    init(
        signinUseCase: any SigninUseCase,
        signupFactory: any SignupFactory
    ) {
        self.signinUseCase = signinUseCase
        self.signupFactory = signupFactory
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
            signinViewController: signinViewController,
            signupFactory: self.signupFactory
        )
    }
}
