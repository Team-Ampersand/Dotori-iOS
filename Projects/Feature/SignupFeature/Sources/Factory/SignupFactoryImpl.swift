import AuthDomainInterface
import DesignSystem
import DWebKit
import SignupFeatureInterface
import Moordinator
import UIKit

struct SignupFactoryImpl: SignupFactory {
    private let loadJwtTokenUseCase: any LoadJwtTokenUseCase

    init(loadJwtTokenUseCase: any LoadJwtTokenUseCase) {
        self.loadJwtTokenUseCase = loadJwtTokenUseCase
    }

    func makeViewController(router: any Router) -> UIViewController {
        let token = loadJwtTokenUseCase.execute()
        let url = "https://dotori-v2.vercel.app/signup"

        let tokenDTO = LocalStorageTokenDTO(
            accessToken: token.accessToken,
            refreshToken: token.refreshToken,
            expiresAt: token.expiresAt
        )
        return DWebViewController(
            urlString: url,
            tokenDTO: tokenDTO
        )
    }
}
