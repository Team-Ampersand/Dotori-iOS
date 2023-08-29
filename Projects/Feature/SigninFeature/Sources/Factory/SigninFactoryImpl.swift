import AuthDomainInterface
import Moordinator
import RenewalPasswordFeatureInterface
import SigninFeatureInterface
import SignupFeatureInterface

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
        let signinStore = SigninStore(
            signinUseCase: self.signinUseCase
        )
        let signinViewController = SigninViewController(store: signinStore)
        return SigninMoordinator(
            signinViewController: signinViewController,
            signupFactory: self.signupFactory,
            renewalPasswordFactory: self.renewalPasswordFactory
        )
    }
}
