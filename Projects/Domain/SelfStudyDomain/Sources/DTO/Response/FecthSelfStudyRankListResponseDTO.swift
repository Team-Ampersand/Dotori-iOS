import BaseDomainInterface
import Foundation
import SelfStudyDomainInterface

struct FetchSelfStudyRankListResponseDTO: Decodable {
    let list: [SelfStudyRankResponseDTO]

    struct SelfStudyRankResponseDTO: Decodable {
        let rank: Int
        let id: Int
        let stuNum: String
        let memberName: String
        let gender: GenderType
        let selfStudyCheck: Bool
        let profileImage: String?
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
            selfStudyCheck: selfStudyCheck,
            profileImage: profileImage ?? ""
        )
    }
}

extension FetchSelfStudyRankListResponseDTO {
    func toDomain() -> [SelfStudyRankEntity] {
        self.list.map { $0.toDomain() }
    }
}
