import AuthDomainInterface
import SigninFeatureInterface
import SignupFeatureInterface
import RenewalPasswordFeatureInterface
import Moordinator

struct SigninFactoryImpl: SigninFactory {
    private let signinUseCase: any SigninUseCase
    private let signupFactory: any SignupFactory
    private let renewalPasswordFactory: any RenewalPasswordFactory

    init(
        signinUseCase: any SigninUseCase,
        signupFactory: any SignupFactory,
        renewalPasswordFactory: any RenewalPasswordFactory
    ) {
        self.signinUseCase = signinUseCase
        self.signupFactory = signupFactory
        self.renewalPasswordFactory = renewalPasswordFactory
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
            signupFactory: self.signupFactory,
            renewalPasswordFactory: self.renewalPasswordFactory
        )
    }
}
