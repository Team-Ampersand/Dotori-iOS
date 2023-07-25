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

    public func toDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "name": name,
            "gender": gender?.rawValue,
            "grade": grade,
            "classNum": classNum
        ]
        return dictionary.compactMapValues { $0 }
    }
}
