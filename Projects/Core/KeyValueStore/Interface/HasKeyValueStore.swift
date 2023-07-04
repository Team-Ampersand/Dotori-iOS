import Foundation

public protocol HasKeyValueStore {
    var keyValueStore: any KeyValueStore { get }
}
