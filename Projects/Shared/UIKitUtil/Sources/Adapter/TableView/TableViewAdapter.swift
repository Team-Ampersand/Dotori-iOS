import UIKit

public final class TableViewAdapter: NSObject {
    private let tableView: UITableView
    private var sections: [any TableViewSectionModel]
    public var viewForHeaderInSection: (UITableView, Int) -> UIView? = { _, _ in nil }
    public var viewForFooterInSection: (UITableView, Int) -> UIView? = { _, _ in nil }

    public init(tableView: UITableView, sections: [any TableViewSectionModel] = []) {
        self.tableView = tableView
        self.sections = sections
    }

    public func updateSections(sections: [any TableViewSectionModel]) {
        self.sections = sections
        tableView.reloadData()
    }
}

extension TableViewAdapter: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return sections[section].count
    }

    public func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return self.viewForHeaderInSection(tableView, section)
    }

    public func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        return self.viewForFooterInSection(tableView, section)
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        return sections[indexPath.section].cell(at: indexPath.row)
    }

    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        sections[indexPath.section].selected(at: indexPath.row)
    }

    public func tableView(
        _ tableView: UITableView,
        didDeselectRowAt indexPath: IndexPath
    ) {
        sections[indexPath.section].deselected(at: indexPath.row)
    }
}

public extension UITableView {
    func setAdapter(adapter: TableViewAdapter) {
        self.delegate = adapter
        self.dataSource = adapter
        self.reloadData()
    }
}
