import UIKit

public final class TableViewAdapter: NSObject {
    private var sections: [any TableViewSectionModel] = []

    public init(sections: [any TableViewSectionModel]) {
        self.sections = sections
    }

    public func updateSections(sections: [any TableViewSectionModel]) {
        self.sections = sections
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
