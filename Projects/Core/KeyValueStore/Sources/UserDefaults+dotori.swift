import Foundation

extension UserDefaults {
    static let dotori = UserDefaults(suiteName: "group.msg.dotori") ?? .standard
}
