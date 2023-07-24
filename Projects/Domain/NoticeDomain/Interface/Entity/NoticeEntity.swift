import BaseDomainInterface
import Foundation

public struct NoticeEntity: Equatable {
    public let id: Int
    public let title: String
    public let content: String
    public let roles: UserRoleType
    public let createdTime: Date

    public init(
        id: Int,
        title: String,
        content: String,
        roles: UserRoleType,
        createdTime: Date
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.roles = roles
        self.createdTime = createdTime
    }
}
