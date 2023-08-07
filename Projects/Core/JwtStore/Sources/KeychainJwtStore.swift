import Foundation
import JwtStoreInterface

final class KeychainJwtStore: JwtStore {
    private let bundleIdentifier: String = Bundle.main.bundleIdentifier ?? ""
    private let appIdentifierPrefix = Bundle.main.infoDictionary!["AppIdentifierPrefix"] as? String ?? ""
    private var accessGroup: String {
        "\(appIdentifierPrefix)com.msg.Dotori.keychainGroup"
    }

    func save(property: JwtStoreProperties, value: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: property.rawValue,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false) ?? .init(),
            kSecAttrAccessGroup: accessGroup
        ]
        SecItemDelete(query)
        SecItemAdd(query, nil)
    }

    func load(property: JwtStoreProperties) -> String {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: property.rawValue,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecAttrAccessGroup: accessGroup
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == errSecSuccess {
            guard let data = dataTypeRef as? Data else { return "" }
            return String(data: data, encoding: .utf8) ?? ""
        }
        return ""
    }

    func delete(property: JwtStoreProperties) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: property.rawValue,
            kSecAttrAccessGroup: accessGroup
        ]
        SecItemDelete(query)
    }
}
