public struct GenericSectionModel<Item>: SectionModelProtocol {
    public typealias Item = Item

    public var items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}
