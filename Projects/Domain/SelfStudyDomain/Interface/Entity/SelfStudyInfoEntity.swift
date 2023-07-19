import Foundation

public struct SelfStudyInfoEntity: Equatable {
    public let count: Int
    public let limit: Int
    public let selfStudyStatus: SelfStudyStatusType

    public init(
        count: Int,
        limit: Int,
        selfStudyStatus: SelfStudyStatusType
    ) {
        self.count = count
        self.limit = limit
        self.selfStudyStatus = selfStudyStatus
    }
}
