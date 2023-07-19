import Foundation

public extension Date {
    func toStringWithCustomFormat(
        _ format: String,
        locale: Locale = .current
    ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        return formatter.string(from: self)
    }
}

public extension String {
    func toDateWithCustomFormat(
        _ format: String,
        locale: Locale = .current
    ) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        return formatter.date(from: self) ?? .init()
    }
}
