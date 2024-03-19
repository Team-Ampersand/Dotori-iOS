import Foundation

public struct ProfileImageEntity: Equatable {
    public let profileImage: String?

    public init(profileImage: String?) {
        self.profileImage = profileImage
    }
}
