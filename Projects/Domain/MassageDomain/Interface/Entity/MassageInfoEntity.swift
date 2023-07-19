import Foundation

public struct MassageInfoEntity: Equatable {
    public let count: Int
    public let limit: Int
    public let massageStatus: MassageStatusType

    public init(count: Int, limit: Int, massageStatus: MassageStatusType) {
        self.count = count
        self.limit = limit
        self.massageStatus = massageStatus
    }
}
