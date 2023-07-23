import ProjectDescriptionHelpers
import ProjectDescription
import ConfigurationPlugin
import DependencyPlugin
import EnvironmentPlugin
import Foundation

let isCI = (ProcessInfo.processInfo.environment["TUIST_CI"] ?? "0") == "1" ? true : false

let configurations: [Configuration] = .default

let settings: Settings =
    .settings(base: env.baseSetting,
              configurations: configurations,
              defaultSettings: .recommended)

let scripts: [TargetScript] = isCI ? [] : [.swiftLint]

let targets: [Target] = [
    .init(
        name: env.name,
        platform: env.platform,
        product: .app,
        bundleId: "\(env.organizationName).\(env.name)",
        deploymentTarget: env.deploymentTarget,
        infoPlist: .file(path: "Support/Info.plist"),
        sources: ["Sources/**"],
        resources: ["Resources/**"],
        entitlements: "Support/Dotori.entitlements",
        scripts: scripts,
        dependencies: [
            .feature(target: .RootFeature),
            .feature(target: .SigninFeature),
            .feature(target: .MainTabFeature),
            .feature(target: .SignupFeature),
            .feature(target: .RenewalPasswordFeature),
            .feature(target: .ConfirmationDialogFeature),
            .domain(target: .AuthDomain),
            .domain(target: .UserDomain),
            .domain(target: .SelfStudyDomain),
            .domain(target: .MassageDomain),
            .domain(target: .MealDomain),
            .core(target: .JwtStore),
            .core(target: .KeyValueStore),
            .core(target: .Networking),
            .core(target: .Database),
            .core(target: .Timer)
        ],
        settings: .settings(base: env.baseSetting)
    )
]

let schemes: [Scheme] = [
    .init(
        name: "\(env.name)-DEV",
        shared: true,
        buildAction: .buildAction(targets: ["\(env.name)"]),
        runAction: .runAction(configuration: .dev),
        archiveAction: .archiveAction(configuration: .dev),
        profileAction: .profileAction(configuration: .dev),
        analyzeAction: .analyzeAction(configuration: .dev)
    ),
    .init(
        name: "\(env.name)-STAGE",
        shared: true,
        buildAction: .buildAction(targets: ["\(env.name)"]),
        runAction: .runAction(configuration: .stage),
        archiveAction: .archiveAction(configuration: .stage),
        profileAction: .profileAction(configuration: .stage),
        analyzeAction: .analyzeAction(configuration: .stage)
    ),
    .init(
        name: "\(env.name)-PROD",
        shared: true,
        buildAction: .buildAction(targets: ["\(env.name)"]),
        runAction: .runAction(configuration: .prod),
        archiveAction: .archiveAction(configuration: .prod),
        profileAction: .profileAction(configuration: .prod),
        analyzeAction: .analyzeAction(configuration: .prod)
    )
]

let project = Project(
    name: env.name,
    organizationName: env.organizationName,
    settings: settings,
    targets: targets,
    schemes: schemes
)
