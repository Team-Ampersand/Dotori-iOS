import Foundation
import MassageDomainInterface

struct FetchMassageInfoResponseDTO: Decodable {
    let count: Int
    let limit: Int
    let massageStatus: MassageStatusType
}

extension FetchMassageInfoResponseDTO {
    func toDomain() -> MassageInfoEntity {
        MassageInfoModel(count: count, limit: limit, massageStatus: massageStatus)
    }
}
