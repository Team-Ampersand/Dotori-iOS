import BaseDomainInterface
import Foundation

public struct FetchSelfStudyRankSearchRequestDTO {
    public let name: String?
    public let gender: GenderType?
    public let grade: Int?
    public let classNum: Int?

    public init(
        name: String? = nil,
        gender: GenderType? = nil,
        grade: Int? = nil,
        classNum: Int? = nil
    ) {
        self.name = name
        self.gender = gender
        self.grade = grade
        self.classNum = classNum
    }

    public func toParameter() -> [String: Any] {
        var dict = [String: Any]()
        if let name {
            dict["name"] = name
        }
        if let gender {
            dict["gender"] = gender.rawValue
        }
        if let grade {
            dict["grade"] = grade
        }
        if let classNum {
            dict["classNum"] = classNum
        }
        return dict
    }
}
