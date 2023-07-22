public protocol SectionModelProtocol {
    associatedtype Item

    var items: [Item] { get }
}
