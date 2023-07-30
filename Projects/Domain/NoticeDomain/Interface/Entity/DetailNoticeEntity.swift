import BaseDomainInterface
import Foundation

public struct DetailNoticeEntity: Equatable {
    public let id: Int
    public let title: String
    public let content: String
    public let role: UserRoleType
    public let images: [NoticeImage]
    public let createdDate: Date
    public let modifiedDate: Date?

    public init(
        id: Int,
        title: String,
        content: String,
        role: UserRoleType,
        images: [DetailNoticeEntity.NoticeImage],
        createdDate: Date,
        modifiedDate: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.role = role
        self.images = images
        self.createdDate = createdDate
        self.modifiedDate = modifiedDate
    }

    public struct NoticeImage: Equatable {
        public let id: Int
        public let imageURL: String

        public init(id: Int, imageURL: String) {
            self.id = id
            self.imageURL = imageURL
        }
    }
}
