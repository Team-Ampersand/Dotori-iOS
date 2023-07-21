import UIKit

public protocol TableViewSectionModel {
    var count: Int { get }
    var viewForHeaderInSection: (UITableView, Int) -> UIView? { get }
    var viewForFooterInSection: (UITableView, Int) -> UIView? { get }
    func cell(at index: Int) -> UITableViewCell
    func selected(at index: Int)
    func deselected(at index: Int)
}
