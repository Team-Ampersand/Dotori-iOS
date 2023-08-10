import Combine
import UIKit

public protocol TableViewAdapterActionProtocol {
    associatedtype Item
    var itemSelected: AnyPublisher<IndexPath, Never> { get }
    var itemDeselected: AnyPublisher<IndexPath, Never> { get }
    var modelSelected: AnyPublisher<Item, Never> { get }
    var modelDeselected: AnyPublisher<Item, Never> { get }
}

public final class TableViewAdapter<Section: SectionModelProtocol>:
    NSObject,
    TableViewAdapterActionProtocol,
    UITableViewDelegate,
    UITableViewDataSource {
    public typealias Item = Section.Item
    private var sections: [Section] = []
    private let tableView: UITableView
    private let configureCell: (UITableView, IndexPath, Item) -> UITableViewCell
    private var viewForHeaderInSection: (UITableView, Int) -> UIView?
    private var viewForFooterInSection: (UITableView, Int) -> UIView?
    private let itemSelectedSubject = PassthroughSubject<IndexPath, Never>()
    private let itemDeselectedSubject = PassthroughSubject<IndexPath, Never>()
    private let modelSelectedSubject = PassthroughSubject<Item, Never>()
    private let modelDeselectedSubject = PassthroughSubject<Item, Never>()

    public init(
        tableView: UITableView,
        configureCell: @escaping (UITableView, IndexPath, Item) -> UITableViewCell,
        viewForHeaderInSection: @escaping (UITableView, Int) -> UIView? = { _, _ in UIView() },
        viewForFooterInSection: @escaping (UITableView, Int) -> UIView? = { _, _ in UIView() }
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

    public var itemSelected: AnyPublisher<IndexPath, Never> {
        itemSelectedSubject.eraseToAnyPublisher()
    }

    public var modelSelected: AnyPublisher<Item, Never> {
        modelSelectedSubject.eraseToAnyPublisher()
    }

    public var itemDeselected: AnyPublisher<IndexPath, Never> {
        itemDeselectedSubject.eraseToAnyPublisher()
    }

    public var modelDeselected: AnyPublisher<Item, Never> {
        modelDeselectedSubject.eraseToAnyPublisher()
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

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemSelectedSubject.send(indexPath)
        let model = sections[indexPath.section].items[indexPath.row]
        modelSelectedSubject.send(model)
    }

    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        itemDeselectedSubject.send(indexPath)
        let model = sections[indexPath.section].items[indexPath.row]
        modelDeselectedSubject.send(model)
    }
}

public extension UITableView {
    func setAdapter<Section: SectionModelProtocol>(adapter: TableViewAdapter<Section>) {
        self.delegate = adapter
        self.dataSource = adapter
        self.reloadData()
    }
}
