// swift-tools-version: 5.7
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
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
    )
#endif

let package = Package(
    name: "Dotori",
    dependencies: [
        .package(url: "https://github.com/Yummypets/YPImagePicker.git", from: "5.2.2"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.2.0"),
        .package(url: "https://github.com/kean/Nuke.git", from: "12.1.4"),
        .package(url: "https://github.com/GSM-MSG/Anim.git", from: "1.1.0"),
        .package(url: "https://github.com/GSM-MSG/Miniature.git", from: "1.3.1"),
        .package(url: "https://github.com/baekteun/NeiSwift.git", from: "2.0.2"),
        .package(url: "https://github.com/krzysztofzablocki/Inject.git", from: "1.2.3"),
        .package(url: "https://github.com/groue/GRDB.swift.git", from: "6.15.1"),
        .package(url: "https://github.com/hackiftekhar/IQKeyboardManager.git", from: "6.5.11"),
        .package(url: "https://github.com/GSM-MSG/Store.git", from: "1.0.1"),
        .package(url: "https://github.com/GSM-MSG/Moordinator.git", from: "2.2.0"),
        .package(url: "https://github.com/GSM-MSG/Emdpoint.git", from: "3.4.0"),
        .package(url: "https://github.com/GSM-MSG/MSGLayout.git", from: "1.3.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.4"),
        .package(url: "https://github.com/GSM-MSG/Configure.git", from: "1.0.1")
    ]
)
