import BaseFeature
import CombineUtility
import DesignSystem
import UIKit
import UIKitUtil

final class MusicViewController: BaseStoredViewController<MusicStore> {
    private let musicNavigationBarLabel = DotoriNavigationBarLabel(text: "기상음악 신청")
    private let calendarBarButton = UIBarButtonItem(
        image: .Dotori.calendar.tintColor(color: .dotori(.neutral(.n20)))
    )
    public let newMusicButton = UIBarButtonItem(
        image: .Dotori.plus.tintColor(color: .dotori(.neutral(.n20)))
    )

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(musicNavigationBarLabel, animated: true)
        self.navigationItem.setRightBarButtonItems([newMusicButton, calendarBarButton], animated: true)
    }
}
