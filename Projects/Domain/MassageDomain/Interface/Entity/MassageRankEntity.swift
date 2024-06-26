import BaseDomainInterface
import Foundation

public struct MassageRankEntity: Equatable {
    public let id: Int
    public let rank: Int
    public let stuNum: String
    public let memberName: String
    public let gender: GenderType
    public let profileImage: String?

    public init(
        id: Int, rank: Int, stuNum: String, memberName: String, gender: GenderType, profileImage: String?
    ) {
        self.id = id
        self.rank = rank
        self.stuNum = stuNum
        self.memberName = memberName
        self.gender = gender
        self.profileImage = profileImage
    }
}
