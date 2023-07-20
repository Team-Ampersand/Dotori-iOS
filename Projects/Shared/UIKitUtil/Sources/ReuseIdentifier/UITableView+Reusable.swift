import UIKit

public extension UITableView {
    func register(cellType: (some UITableViewCell).Type) {
        self.register(
            cellType.self,
            forCellReuseIdentifier: cellType.reuseIdentifier
        )
    }

    func dequeueReusableCell<T: UITableViewCell>(
        for indexPath: IndexPath,
        cellType: T.Type = T.self
    ) -> T {
        guard let cell = self.dequeueReusableCell(
            withIdentifier: cellType.reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) "
                + "matching type \(cellType.self)."
            )
        }
        return cell
    }

    func register(headerFooterViewType: (some UITableViewHeaderFooterView).Type) {
        self.register(
            headerFooterViewType.self,
            forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier
        )
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(
        _ viewType: T.Type = T.self
    ) -> T? {
        guard let view = self.dequeueReusableHeaderFooterView(
            withIdentifier: viewType.reuseIdentifier
        ) as? T? else {
            fatalError(
                "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) "
                + "matching type \(viewType.self)."
            )
        }
        return view
    }
}
