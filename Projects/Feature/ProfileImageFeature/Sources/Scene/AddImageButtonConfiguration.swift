import BaseFeature
import Combine
import ConcurrencyUtil
import DesignSystem
import Foundation
import Localization
import MSGLayout
import Nuke
import UIKit
import UIKitUtil
import UserDomainInterface
import YPImagePicker

enum AddImageButtonConfigutionGenerater {
    static func generate() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "camera.fill")
        configuration.imagePlacement = .top
        configuration.imagePadding = 10
        configuration.background.backgroundColor = .dotori(.background(.bg))
        configuration.title = L10n.ProfileImage.addImage
        configuration.titleAlignment = .center
        configuration.attributedTitle?.foregroundColor = .dotori(.neutral(.n20))
        configuration.attributedTitle?.font = .dotori(.caption)
        configuration.baseForegroundColor = .dotori(.primary(.p30))
        configuration.background.cornerRadius = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: 112, leading: 108, bottom: 104, trailing: 108
        )
        return configuration
    }
}
