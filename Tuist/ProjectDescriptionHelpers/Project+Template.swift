import ConfigurationPlugin
import DependencyPlugin
import EnvironmentPlugin
import Foundation
import ProjectDescription

public enum MicroFeatureTarget {
    case interface
    case testing
    case unitTest
    case uiTest
    case demo
}

public extension Project {
    static func makeModule(
        name: String,
        destination: Set<Destination> = env.destination,
        product: Product,
        targets: Set<MicroFeatureTarget>,
        packages: [Package] = [],
        externalDependencies: [TargetDependency] = [],
        internalDependencies: [TargetDependency] = [],
        interfaceDependencies: [TargetDependency] = [],
        testingDependencies: [TargetDependency] = [],
        unitTestDependencies: [TargetDependency] = [],
        uiTestDependencies: [TargetDependency] = [],
        demoDependencies: [TargetDependency] = [],
        sources: SourceFilesList = .sources,
        resources: ResourceFileElements? = nil,
        settings: SettingsDictionary = [:],
        additionalPlistRows: [String: Plist.Value] = [:],
        additionalFiles: [FileElement] = [],
        configurations: [Configuration] = [],
        resourceSynthesizers: [ResourceSynthesizer] = .default
    ) -> Project {
        let scripts: [TargetScript] = generateEnvironment.scripts
        let ldFlagsSettings: SettingsDictionary = product == .framework ?
        ["OTHER_LDFLAGS": .string("$(inherited) -all_load")] :
        ["OTHER_LDFLAGS": .string("$(inherited)")]

        var configurations = configurations
        if configurations.isEmpty {
            configurations = .default
        }

        let settings: Settings = .settings(
            base: env.baseSetting
                .merging(settings)
                .merging(ldFlagsSettings),
            configurations: configurations,
            defaultSettings: .recommended
        )
        var allTargets: [Target] = []
        var dependencies = internalDependencies + externalDependencies

        // MARK: - Interface
        if targets.contains(.interface) {
            dependencies.append(.target(name: "\(name)Interface"))
            allTargets.append(
                .target(
                    name: "\(name)Interface",
                    destinations: destination,
                    product: .framework,
                    bundleId: "\(env.organizationName).\(name)Interface",
                    deploymentTargets: env.deploymentTargets,
                    infoPlist: .default,
                    sources: .interface,
                    scripts: scripts,
                    dependencies: interfaceDependencies,
                    additionalFiles: additionalFiles
                )
            )
        }

        // MARK: - Sources
        allTargets.append(
            .target(
                name: name,
                destinations: destination,
                product: product,
                bundleId: "\(env.organizationName).\(name)",
                deploymentTargets: env.deploymentTargets,
                infoPlist: .extendingDefault(with: additionalPlistRows),
                sources: sources,
                resources: resources,
                scripts: scripts,
                dependencies: dependencies
            )
        )

        // MARK: - Testing
        if targets.contains(.testing) && targets.contains(.interface) {
            allTargets.append(
                .target(
                    name: "\(name)Testing",
                    destinations: destination,
                    product: .framework,
                    bundleId: "\(env.organizationName).\(name)Testing",
                    deploymentTargets: env.deploymentTargets,
                    infoPlist: .default,
                    sources: .testing,
                    scripts: scripts,
                    dependencies: [
                        .target(name: "\(name)Interface")
                    ] + testingDependencies
                )
            )
        }

        var testTargetDependencies = [
            targets.contains(.demo) ?
                TargetDependency.target(name: "\(name)Demo") :
                TargetDependency.target(name: name)
        ]
        if targets.contains(.testing) {
            testTargetDependencies.append(.target(name: "\(name)Testing"))
        }

        // MARK: - Unit Test
        if targets.contains(.unitTest) {
            allTargets.append(
                .target(
                    name: "\(name)Tests",
                    destinations: destination,
                    product: .unitTests,
                    bundleId: "\(env.organizationName).\(name)Tests",
                    deploymentTargets: env.deploymentTargets,
                    infoPlist: .default,
                    sources: .unitTests,
                    scripts: scripts,
                    dependencies: testTargetDependencies + unitTestDependencies
                )
            )
        }

        // MARK: - UI Test
        if targets.contains(.uiTest) {
            allTargets.append(
                .target(
                    name: "\(name)UITests",
                    destinations: destination,
                    product: .uiTests,
                    bundleId: "\(env.organizationName).\(name)UITests",
                    deploymentTargets: env.deploymentTargets,
                    infoPlist: .default,
                    scripts: scripts,
                    dependencies: testTargetDependencies + uiTestDependencies
                )
            )
        }

        // MARK: - Demo App
        if targets.contains(.demo) {
            var demoDependencies = demoDependencies
            demoDependencies.append(.target(name: name))
            if targets.contains(.testing) {
                demoDependencies.append(.target(name: "\(name)Testing"))
            }
            allTargets.append(
                .target(
                    name: "\(name)Demo",
                    destinations: destination,
                    product: .app,
                    bundleId: "\(env.organizationName).\(name)Demo",
                    deploymentTargets: env.deploymentTargets,
                    infoPlist: .extendingDefault(with: [
                        "UIMainStoryboardFile": "",
                        "UILaunchStoryboardName": "LaunchScreen",
                        "ENABLE_TESTS": .boolean(true),
                    ]),
                    sources: .demoSources,
                    resources: ["Demo/Resources/**"],
                    scripts: scripts,
                    dependencies: demoDependencies
                )
            )
        }

        let schemes: [Scheme] = targets.contains(.demo) ?
        [.makeScheme(target: .dev, name: name), .makeDemoScheme(target: .dev, name: name)] :
        [.makeScheme(target: .dev, name: name)]

        return Project(
            name: name,
            organizationName: env.organizationName,
            packages: packages,
            settings: settings,
            targets: allTargets,
            schemes: schemes,
            resourceSynthesizers: resourceSynthesizers
        )
    }
}

extension Scheme {
    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return .scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
    static func makeDemoScheme(target: ConfigurationName, name: String) -> Scheme {
        return .scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)Demo"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)Demo"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}
