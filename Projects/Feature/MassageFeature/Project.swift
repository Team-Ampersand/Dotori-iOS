import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.MassageFeature.rawValue,
    targets: [
        .implements(module: .feature(.MassageFeature), dependencies: [
            .feature(target: .BaseFeature),
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .feature(.MassageFeature), dependencies: [
            .feature(target: .MassageFeature)
        ])
    ]
)
