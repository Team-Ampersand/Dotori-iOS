import Foundation
import UserDomainInterface

struct FetchProfileImageResponseDTO: Decodable {
    let profileImage: String
}

extension FetchProfileImageResponseDTO {
    func toDomain() -> String {
        self.profileImage
    }
}
