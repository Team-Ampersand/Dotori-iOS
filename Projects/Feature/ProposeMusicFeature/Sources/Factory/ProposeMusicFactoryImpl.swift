import BaseFeature
import BaseFeatureInterface
import MusicDomainInterface
import ProposeMusicFeatureInterface
import UIKit

struct ProposeMusicFactoryImpl: ProposeMusicFactory {
    private let proposeMusicUseCase: any ProposeMusicUseCase

    init(proposeMusicUseCase: any ProposeMusicUseCase) {
        self.proposeMusicUseCase = proposeMusicUseCase
    }

    func makeViewController() -> any RoutedViewControllable {
        let store = ProposeMusicStore(
            proposeMusicUseCase: proposeMusicUseCase
        )
        return ProposeMusicViewController(store: store)
    }
}
