import ProjectDescription
import ConfigurationPlugin

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .remote(url: "https://github.com/GSM-MSG/Emdpoint.git", requirement: .exact("1.1.0")),
            .remote(url: "https://github.com/GSM-MSG/MSGLayout.git", requirement: .exact("1.1.0")),
            .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .exact("2.8.3")),
    
        ],
        baseSettings: .settings(
            configurations: [
                .debug(name: .dev),
                .debug(name: .stage),
                .release(name: .prod)
            ]
        )
    ),
    platforms: [.iOS]
)
