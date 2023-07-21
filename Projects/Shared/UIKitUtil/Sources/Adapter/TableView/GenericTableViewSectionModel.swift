import UIKit

public final class GenericTableViewSectionModel<Model, Cell>:
    TableViewSectionModel
where Cell: UITableViewCell, Cell: AdaptableCell, Model == Cell.Model {
    private let models: [Model]
    private lazy var cells: [Cell] = makeCells()

    public init(models: [Model]) {
        self.models = models
    }

    public var count: Int {
        models.count
    }

    public func cell(at index: Int) -> UITableViewCell {
        return cells[index]
    }

    public func selected(at index: Int) {}

    public func deselected(at index: Int) {}

    private func makeCells() -> [Cell] {
        return models.map {
            let cell = Cell()
            cell.adapt(model: $0)
            return cell
        }
    }
}
