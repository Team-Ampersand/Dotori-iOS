import UIKit

public protocol TableViewSectionModel {
    var count: Int { get }
    func cell(at index: Int) -> UITableViewCell
    func selected(at index: Int)
    func deselected(at index: Int)
}
