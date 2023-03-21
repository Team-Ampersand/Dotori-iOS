import AuthDomainInterface
import DWebKit
import RenewalPasswordFeatureInterface
import Moordinator
import UIKit

struct RenewalPasswordFactoryImpl: RenewalPasswordFactory {
    private let loadJwtTokenUseCase: any LoadJwtTokenUseCase

    init(loadJwtTokenUseCase: any LoadJwtTokenUseCase) {
        self.loadJwtTokenUseCase = loadJwtTokenUseCase
    }

    func makeViewController(router: Router) -> UIViewController {
        let token = loadJwtTokenUseCase.execute()
        let url = "https://dotori-v2.vercel.app/changePasswd"

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
