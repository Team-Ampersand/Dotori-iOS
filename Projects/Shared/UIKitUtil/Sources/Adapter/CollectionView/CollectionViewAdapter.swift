import Combine
import UIKit

public protocol CollectionViewViewAdapterActionProtocol {
    associatedtype Item
    var itemSelected: AnyPublisher<IndexPath, Never> { get }
    var itemDeselected: AnyPublisher<IndexPath, Never> { get }
    var modelSelected: AnyPublisher<Item, Never> { get }
    var modelDeselected: AnyPublisher<Item, Never> { get }
}

public final class CollectionViewAdapter<Section: SectionModelProtocol>:
    NSObject,
    CollectionViewViewAdapterActionProtocol,
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
    private let itemSelectedSubject = PassthroughSubject<IndexPath, Never>()
    private let itemDeselectedSubject = PassthroughSubject<IndexPath, Never>()
    private let modelSelectedSubject = PassthroughSubject<Item, Never>()
    private let modelDeselectedSubject = PassthroughSubject<Item, Never>()

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

    public func updateSections(sections: [Section]) {
        self.sections = sections
        collectionView.reloadData()
    }

    public func updateViewForSupplementaryElementOfKind(
        _ viewForSupplementaryElementOfKind: @escaping (
            UICollectionView,
            String,
            IndexPath
        ) -> UICollectionReusableView
    ) {
        self.viewForSupplementaryElementOfKind = viewForSupplementaryElementOfKind
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

    // MARK: - CollectionView Delegate & DataSouce

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

    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        itemSelectedSubject.send(indexPath)
        let model = sections[indexPath.section].items[indexPath.row]
        modelSelectedSubject.send(model)
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {
        itemDeselectedSubject.send(indexPath)
        let model = sections[indexPath.section].items[indexPath.row]
        modelDeselectedSubject.send(model)
    }
}

public extension UICollectionView {
    func setAdapter(adapter: CollectionViewAdapter<some SectionModelProtocol>) {
        self.delegate = adapter
        self.dataSource = adapter
        self.reloadData()
    }
}
