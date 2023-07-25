import DateUtility
import Foundation
import ViolationDomainInterface

struct ViolationResponseDTO: Decodable {
    let id: Int
    let rule: String
    let createdDate: String
}

extension ViolationResponseDTO {
    func toDomain() -> ViolationEntity {
        ViolationEntity(
            id: id,
            rule: rule,
            createDate: createdDate.toDateWithCustomFormat("yyyy-MM-dd")
        )
    }
}
