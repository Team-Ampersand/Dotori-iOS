import BaseFeature
import BaseFeatureInterface
import Combine
import ConcurrencyUtil
import DesignSystem
import Foundation
import Localization
import Moordinator
import MSGLayout
import Nuke
import ProfileImageFeature
import UIKit
import UIKitUtil
import UserDomainInterface
import YPImagePicker

final class ImagePickerController: YPImagePicker, RoutedViewControllable {
    var router: Router = DefaultRouter()
    var configuration: YPImagePickerConfiguration
    var closure: (Data) -> Void

    convenience init(closure: @escaping ((Data) -> Void)) {
        var config = YPImagePickerConfiguration()
        config.startOnScreen = .library
        config.library.maxNumberOfItems = 1
        config.library.mediaType = .photo
        config.library.defaultMultipleSelection = false
        config.showsCrop = .rectangle(ratio: 4/4)
        self.init(configuration: config, closure: closure)
        self.didFinishPicking { [weak self] items, cancelled in
            guard let self else { return }
            if cancelled {
                self.router.route.send(DotoriRoutePath.dismiss)
            }
            if let photo = items.singlePhoto,
               let imageData = photo.image.jpegData(compressionQuality: 0.6) {
                closure(imageData)
            }
        }
    }

    init(configuration: YPImagePickerConfiguration, closure: @escaping ((Data) -> Void)) {
        self.configuration = configuration
        self.closure = closure
        super.init(configuration: configuration)
    }

    required init(configuration: YPImagePickerConfiguration) {
        self.configuration = configuration
        self.closure = { _ in }
        super.init(configuration: configuration)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
