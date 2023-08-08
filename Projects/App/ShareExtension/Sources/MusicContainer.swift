import Swinject
import MusicDomain
import JwtStore
import Networking
import KeyValueStore

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
