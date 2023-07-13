import Foundation
import SelfStudyDomainInterface

struct FetchSelfStudyInfoResponseDTO: Decodable {
    let count: Int
    let limit: Int
    let selfStudyStatus: SelfStudyStatusType
}

extension FetchSelfStudyInfoResponseDTO {
    func toEntity() -> SelfStudyInfoEntity {
        SelfStudyInfoEntity(count: count, limit: limit, selfStudyStatus: selfStudyStatus)
    }
}
