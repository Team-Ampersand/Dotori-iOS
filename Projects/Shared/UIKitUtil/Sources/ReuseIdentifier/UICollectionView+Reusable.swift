import UIKit

public extension UICollectionView {
    func register(cellType: (some UICollectionViewCell).Type) {
        self.register(
            cellType.self,
            forCellWithReuseIdentifier: cellType.reuseIdentifier
        )
    }

    func dequeueReusableCell<T: UICollectionViewCell>(
        for indexPath: IndexPath,
        cellType: T.Type = T.self
    ) -> T {
        let dequeueCell = self.dequeueReusableCell(
            withReuseIdentifier: cellType.reuseIdentifier,
            for: indexPath
        )
        guard let cell = dequeueCell as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) "
                    + "matching type \(cellType.self)."
            )
        }
        return cell
    }

    func register(
        supplementaryViewType: (some UICollectionReusableView).Type,
        ofKind elementKind: String
    ) {
        self.register(
            supplementaryViewType.self,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: supplementaryViewType.reuseIdentifier
        )
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        ofKind elementKind: String,
        for indexPath: IndexPath,
        viewType: T.Type = T.self
    ) -> T {
        let supplementaryView = self.dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: viewType.reuseIdentifier,
            for: indexPath
        )
        guard let typedView = supplementaryView as? T else {
            fatalError(
                "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) "
                    + "matching type \(viewType.self)."
            )
        }
        return typedView
    }
}
