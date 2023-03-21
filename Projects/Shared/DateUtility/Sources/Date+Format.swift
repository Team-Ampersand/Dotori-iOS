import Foundation

public extension Date {
    func toStringWithCustomFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter.string(from: self)
    }
}

public extension String {
    func toDateWithCustomFormat(_ format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ko_kr")
        return formatter.date(from: self) ?? .init()
    }
}
