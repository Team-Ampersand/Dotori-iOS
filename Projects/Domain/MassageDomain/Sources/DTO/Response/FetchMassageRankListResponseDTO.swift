import BaseDomainInterface
import Foundation
import MassageDomainInterface

struct FetchMassageRankListResponseDTO: Decodable {
    let list: [MassageRankResponseDTO]

    struct MassageRankResponseDTO: Decodable {
        let id: Int
        let rank: Int
        let stuNum: String
        let memberName: String
        let gender: GenderType
        let profileImage: String?
    }
}

extension FetchMassageRankListResponseDTO {
    func toDomain() -> [MassageRankEntity] {
        self.list
            .map { $0.toDomain() }
    }
}

extension FetchMassageRankListResponseDTO.MassageRankResponseDTO {
    func toDomain() -> MassageRankEntity {
        MassageRankEntity(
            id: id,
            rank: rank,
            stuNum: stuNum,
            memberName: memberName,
            gender: gender,
            profileImage: profileImage
        )
    }
}
