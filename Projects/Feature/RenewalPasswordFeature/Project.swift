import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.RenewalPasswordFeature.rawValue,
    targets: [
        .interface(module: .feature(.RenewalPasswordFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.RenewalPasswordFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .RenewalPasswordFeature, type: .interface),
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .feature(.RenewalPasswordFeature), dependencies: [
            .feature(target: .RenewalPasswordFeature)
        ])
    ]
)
