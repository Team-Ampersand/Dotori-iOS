import Foundation

public struct ViolationEntity: Equatable {
    public let id: Int
    public let rule: String
    public let createDate: Date

    public init(id: Int, rule: String, createDate: Date) {
        self.id = id
        self.rule = rule
        self.createDate = createDate
    }
}
