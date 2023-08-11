import JwtStore
import KeyValueStore
import MusicDomain
import Networking
import Swinject

final class MusicContainer {
    static let shared = MusicContainer()

    let container = Container()
    var assembler: Assembler?

    init() {
        assembler = Assembler([
            KeyValueStoreAssembly(),
            JwtStoreAssembly(),
            NetworkingAssembly(),
            MusicDomainAssembly()
        ], container: container)
    }
}
