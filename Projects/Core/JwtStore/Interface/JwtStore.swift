public enum JwtStoreProperties: String {
    case accessToken = "ACCESS-TOKEN"
    case refreshToken = "REFRESH-TOKEN"
    case accessExpiresAt = "ACCESS-EXPIRES-AT"
}

public protocol JwtStore {
    func save(property: JwtStoreProperties, value: String)
    func load(property: JwtStoreProperties) -> String
    func delete(property: JwtStoreProperties)
}
