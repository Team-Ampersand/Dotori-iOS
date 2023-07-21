import BaseDomainInterface
import DateUtility
import Foundation
import NoticeDomainInterface

struct FetchNoticeListResponseDTO: Decodable {
    let boardList: [NoticeResponseDTO]

    struct NoticeResponseDTO: Decodable {
        let id: Int
        let title: String
        let content: String
        let roles: UserRoleType
        let createdTime: String
    }
}

extension FetchNoticeListResponseDTO.NoticeResponseDTO {
    func toEntity() -> NoticeEntity {
        .init(
            id: id,
            title: title,
            content: content,
            roles: roles,
            createdTime: createdTime.toDateWithCustomFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
        )
    }
}

extension FetchNoticeListResponseDTO {
    func toEntity() -> [NoticeEntity] {
        self.boardList
            .map { $0.toEntity() }
    }
}