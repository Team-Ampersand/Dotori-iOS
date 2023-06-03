import Emdpoint

public protocol HasEmdpointClient {
    associatedtype Endpoint: DotoriEndpoint

    var client: EmdpointClient<Endpoint> { get }
}
