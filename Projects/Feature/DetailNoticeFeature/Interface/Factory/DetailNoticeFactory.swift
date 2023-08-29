import BaseFeatureInterface
import UIKit

public protocol DetailNoticeFactory {
    func makeViewController(noticeID: Int) -> any RoutedViewControllable
}
