public enum JwtStoreProperties: String {
    case accessToken = "ACCESS-TOKEN"
    case refreshToken = "REFRESH-TOKEN"
    case accessExp = "ACCESS-EXP"
    case refreshExp = "REFRESH-EXP"
}

public protocol JwtStore {
    func save(property: JwtStoreProperties, value: String)
    func load(property: JwtStoreProperties) -> String
    func delete(property: JwtStoreProperties)
}

public protocol HasJwtStore {
    var jwtStore: any JwtStore { get }
}
