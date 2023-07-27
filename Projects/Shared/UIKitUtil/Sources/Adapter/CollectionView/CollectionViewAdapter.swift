import Combine
import UIKit


public final class CollectionViewAdapter<Section: SectionModelProtocol>:
    NSObject,
UICollectionViewDelegate,
UICollectionViewDataSource {
    
    public typealias Item = Section.Item
    private var sections: [Section] = []
    private let collectionView: UICollectionView
    private let configureCell: (UICollectionView, IndexPath, Item) -> UICollectionViewCell
    public var viewForSupplementaryElementOfKind: (
        UICollectionView,
        String,
        IndexPath
    ) -> UICollectionReusableView = { _, _, _ in .init() }

    public init(
        collectionView: UICollectionView,
        configureCell: @escaping (UICollectionView, IndexPath, Item) -> UICollectionViewCell,
        viewForSupplementaryElementOfKind: @escaping (
            UICollectionView,
            String,
            IndexPath
        ) -> UICollectionReusableView = { _, _, _ in .init() }
    ) {
        self.collectionView = collectionView
        self.configureCell = configureCell
        self.viewForSupplementaryElementOfKind = viewForSupplementaryElementOfKind
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return sections[section].items.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return self.configureCell(
            collectionView,
            indexPath,
            sections[indexPath.section].items[indexPath.row]
        )
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        return self.viewForSupplementaryElementOfKind(
            collectionView,
            kind,
            indexPath
        )
    }
}
