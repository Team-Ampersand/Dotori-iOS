import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.RenewalPasswordFeature.rawValue,
    targets: [
        .implements(module: .feature(.RenewalPasswordFeature), dependencies: [
            .feature(target: .BaseFeature),
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .feature(.RenewalPasswordFeature), dependencies: [
            .feature(target: .RenewalPasswordFeature)
        ])
    ]
)
