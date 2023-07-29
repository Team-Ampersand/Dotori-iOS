import BaseFeature
import UIKit

public protocol DetailNoticeFactory {
    func makeViewController(noticeID: Int) -> any StoredViewControllable
}
