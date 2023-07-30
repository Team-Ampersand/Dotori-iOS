import BaseFeature
import MusicDomainInterface
import UIKit

struct ProposeMusicFactoryImpl: ProposeMusicFactory {
    private let proposeMusicUseCase: any ProposeMusicUseCase

    init(proposeMusicUseCase: any ProposeMusicUseCase) {
        self.proposeMusicUseCase = proposeMusicUseCase
    }

    func makeViewController() -> any StoredViewControllable {
        let store = ProposeMusicStore(
            proposeMusicUseCase: proposeMusicUseCase
        )
        return ProposeMusicViewController(store: store)
    }
}
