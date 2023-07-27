import Foundation

public struct MusicEntity: Equatable {
    public let id: Int
    public let url: String
    public let username: String
    public let createdTime: Date
    public let stuNum: String

    public init(id: Int, url: String, username: String, createdTime: Date, stuNum: String) {
        self.id = id
        self.url = url
        self.username = username
        self.createdTime = createdTime
        self.stuNum = stuNum
    }
}
