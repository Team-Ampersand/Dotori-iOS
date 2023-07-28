import BaseDomainInterface
import DateUtility
import Foundation
import NoticeDomainInterface

struct FetchNoticeResponseDTO: Decodable {
    let id: Int
    let title: String
    let content: String
    let role: UserRoleType
    let boardImage: [BoardImage]
    let createdDate: String
    let modifiedDate: String?

    struct BoardImage: Decodable {
        let id: Int
        let url: String

        init(id: Int, url: String) {
            self.id = id
            self.url = url
        }
    }
}

extension FetchNoticeResponseDTO {
    func toDomain() -> DetailNoticeEntity {
        DetailNoticeEntity(
            id: id,
            title: title,
            content: content,
            role: role,
            images: boardImage.map { $0.toDomain() },
            createdDate: createdDate.toDateWithCustomFormat("yyyy-MM-dd'T'HH:mm:ss.SSS"),
            modifiedDate: modifiedDate?.toDateWithCustomFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
        )
    }
}

extension FetchNoticeResponseDTO.BoardImage {
    func toDomain() -> DetailNoticeEntity.NoticeImage {
        .init(id: id, imageURL: url)
    }
}
