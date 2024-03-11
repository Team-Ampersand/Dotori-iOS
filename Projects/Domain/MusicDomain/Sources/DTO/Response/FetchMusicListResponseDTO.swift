import DateUtility
import Foundation
import MusicDomainInterface

struct FetchMusicListResponseDTO: Decodable {
    let content: [MusicResponseDTO]

    struct MusicResponseDTO: Decodable {
        let id: Int
        let url: String
        let username: String
        let email: String
        let createdTime: String
        let stuNum: String
    }
}

extension FetchMusicListResponseDTO {
    func toDomain() -> [MusicEntity] {
        self.content
            .map { $0.toDomain() }
    }
}

extension FetchMusicListResponseDTO.MusicResponseDTO {
    func toDomain() -> MusicEntity {
        MusicEntity(
            id: id,
            url: url,
            username: username,
            createdTime: createdTime.toDateWithCustomFormat("yyyy-MM-dd'T'HH:mm:ss"),
            stuNum: stuNum
        )
    }
}
