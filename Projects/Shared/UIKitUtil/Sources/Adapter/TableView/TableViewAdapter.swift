import UIKit

public final class TableViewAdapter<Section: SectionModelProtocol>:
    NSObject,
    UITableViewDelegate,
    UITableViewDataSource {

    public typealias Item = Section.Item
    private let tableView: UITableView
    private var sections: [Section] = []
    private var configureCell: (UITableView, IndexPath, Item) -> UITableViewCell
    private var viewForHeaderInSection: (UITableView, Int) -> UIView? = { _, _ in nil }
    private var viewForFooterInSection: (UITableView, Int) -> UIView? = { _, _ in nil }

    public init(
        tableView: UITableView,
        configureCell: @escaping (UITableView, IndexPath, Item) -> UITableViewCell,
        viewForHeaderInSection: @escaping (UITableView, Int) -> UIView? = { _, _ in nil },
        viewForFooterInSection: @escaping (UITableView, Int) -> UIView? = { _, _ in nil }
    ) {
        self.tableView = tableView
        self.configureCell = configureCell
        self.viewForHeaderInSection = viewForHeaderInSection
        self.viewForFooterInSection = viewForFooterInSection
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }

    public func updateSections(sections: [Section]) {
        self.sections = sections
        tableView.reloadData()
    }

    public func setViewForHeaderInSection(
        _ viewForHeaderInSection: @escaping (UITableView, Int) -> UIView?
    ) {
        self.viewForHeaderInSection = viewForHeaderInSection
    }

    public func setViewForFooterInSection(
        _ viewForFooterInSection: @escaping (UITableView, Int) -> UIView?
    ) {
        self.viewForFooterInSection = viewForFooterInSection
    }

    // MARK: - TableView Delegate & DataSource

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return sections[section].items.count
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
        return self.configureCell(
            tableView,
            indexPath,
            sections[indexPath.section].items[indexPath.row]
        )
    }
}

public extension UITableView {
    func setAdapter<Section: SectionModelProtocol>(adapter: TableViewAdapter<Section>) {
        self.delegate = adapter
        self.dataSource = adapter
        self.reloadData()
    }
}
