import Foundation
import ViolationDomainInterface

struct FetchMyViolationListResponseDTO: Decodable {
    let rules: [ViolationResponseDTO]
}

extension FetchMyViolationListResponseDTO {
    func toDomain() -> [ViolationEntity] {
        self.rules
            .map { $0.toDomain() }
    }
}
