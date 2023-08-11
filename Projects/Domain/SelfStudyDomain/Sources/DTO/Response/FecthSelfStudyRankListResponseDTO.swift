import BaseDomainInterface
import Foundation
import SelfStudyDomainInterface

struct FetchSelfStudyRankListResponseDTO: Decodable {
    let list: [SelfStudyRankResponseDTO]

    struct SelfStudyRankResponseDTO: Decodable {
        let id: Int
        let rank: Int
        let stuNum: String
        let memberName: String
        let gender: GenderType
        let selfStudyCheck: Bool
    }
}

extension FetchSelfStudyRankListResponseDTO.SelfStudyRankResponseDTO {
    func toDomain() -> SelfStudyRankEntity {
        SelfStudyRankEntity(
            id: id,
            rank: rank,
            stuNum: stuNum,
            memberName: memberName,
            gender: gender,
            selfStudyCheck: selfStudyCheck
        )
    }
}

extension FetchSelfStudyRankListResponseDTO {
    func toDomain() -> [SelfStudyRankEntity] {
        self.list.map { $0.toDomain() }
    }
}
