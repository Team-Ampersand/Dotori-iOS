import Foundation
import JwtStoreInterface

public struct KeychainJwtStore: JwtStore {
    public func save(property: JwtStoreProperties, value: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: property.rawValue,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false) ?? .init()
        ]
        SecItemDelete(query)
        SecItemAdd(query, nil)
    }

    public func load(property: JwtStoreProperties) -> String {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: property.rawValue,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == errSecSuccess {
            guard let data = dataTypeRef as? Data else { return "" }
            return String(data: data, encoding: .utf8) ?? ""
        }
        return ""
    }

    public func delete(property: JwtStoreProperties) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: property.rawValue
        ]
        SecItemDelete(query)
    }
}
