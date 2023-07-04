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

        container.register((any Networking<AuthEndpoint>).self) { [weak self] resolver in
            let client = EmdpointClient<AuthEndpoint>(
                interceptors: self?.makeInterceptors(container: container, resolver: resolver) ?? []
            )
            return NetworkingImpl(client: client)
        }
    }

    func makeInterceptors(container: Container, resolver: Resolver) -> [any InterceptorType] {
        #if DEV || STAGE
        return [
            resolver.resolve(JwtInterceptor.self)!,
            resolver.resolve(DotoriLoggingInterceptor.self)!,
            resolver.resolve(DotoriRoleInterceptor.self)!
        ]
        #else
        return [
            resolver.resolve(JwtInterceptor.self)!,
            resolver.resolve(DotoriRoleInterceptor.self)!
        ]
        #endif
    }
}
