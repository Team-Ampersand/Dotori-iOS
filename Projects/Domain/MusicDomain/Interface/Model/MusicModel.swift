import Foundation
import UIKit

public struct MusicModel: Equatable {
    public let id: Int
    public let url: String
    public let title: String?
    public let thumbnailUIImage: UIImage?
    public let username: String
    public let createdTime: Date
    public let stuNum: String

    public init(
        id: Int,
        url: String,
        title: String?,
        thumbnailUIImage: UIImage?,
        username: String,
        createdTime: Date,
        stuNum: String
    ) {
        self.id = id
        self.url = url
        self.title = title
        self.thumbnailUIImage = thumbnailUIImage
        self.username = username
        self.createdTime = createdTime
        self.stuNum = stuNum
    }
}
