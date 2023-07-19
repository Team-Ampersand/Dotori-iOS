import Emdpoint
import Foundation
import JwtStoreInterface
import KeyValueStoreInterface
import NetworkingInterface
import Swinject

public final class NetworkingAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(JwtInterceptor.self) { resolver in
            JwtInterceptor(jwtStore: resolver.resolve(JwtStore.self)!)
        }

        #if DEV || STAGE
        container.register(DotoriLoggingInterceptor.self) { _ in
            DotoriLoggingInterceptor()
        }
        #endif

        container.register(DotoriRoleInterceptor.self) { resolver in
            DotoriRoleInterceptor(keyValueStore: resolver.resolve(KeyValueStore.self)!)
        }

        container.register([any InterceptorType].self) { resolver in
            #if DEV || STAGE
            return [
                resolver.resolve(JwtInterceptor.self)!,
                resolver.resolve(DotoriRoleInterceptor.self)!,
                resolver.resolve(DotoriLoggingInterceptor.self)!
            ]
            #else
            return [
                resolver.resolve(JwtInterceptor.self)!,
                resolver.resolve(DotoriRoleInterceptor.self)!
            ]
            #endif
        }

        container.register(Networking.self) { resolver in
            let client = EmdpointClient<AnyEndpoint>(
                interceptors: resolver.resolve([any InterceptorType].self)!
            )
            return NetworkingImpl(client: client)
        }
    }
}
