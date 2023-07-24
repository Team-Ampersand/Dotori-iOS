import ProjectDescription
import ConfigurationPlugin

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .remote(url: "https://github.com/GSM-MSG/Anim.git", requirement: .exact("1.1.0")),
            .remote(url: "https://github.com/GSM-MSG/Miniature.git", requirement: .exact("1.3.1")),
            .remote(url: "https://github.com/baekteun/NeiSwift.git", requirement: .exact("2.0.2")),
            .remote(url: "https://github.com/krzysztofzablocki/Inject.git", requirement: .exact("1.2.3")),
            .remote(url: "https://github.com/groue/GRDB.swift.git", requirement: .exact("6.15.1")),
            .remote(url: "https://github.com/hackiftekhar/IQKeyboardManager.git", requirement: .exact("6.5.11")),
            .remote(url: "https://github.com/GSM-MSG/Store.git", requirement: .exact("1.0.1")),
            .remote(url: "https://github.com/GSM-MSG/Moordinator.git", requirement: .exact("2.2.0")),
            .remote(url: "https://github.com/GSM-MSG/Emdpoint.git", requirement: .exact("3.3.0")),
            .remote(url: "https://github.com/GSM-MSG/MSGLayout.git", requirement: .exact("1.3.0")),
            .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .exact("2.8.3")),
            .remote(url: "https://github.com/GSM-MSG/Configure.git", requirement: .exact("1.0.1"))
        ],
        productTypes: [
            "Moordinator": .framework,
            "CombineMiniature": .framework
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
