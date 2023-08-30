import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.MassageFeature.rawValue,
    targets: [
        .interface(module: .feature(.MassageFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.MassageFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .MassageFeature, type: .interface),
            .domain(target: .MassageDomain, type: .interface),
            .domain(target: .UserDomain, type: .interface)
        ]),
        .tests(module: .feature(.MassageFeature), dependencies: [
            .feature(target: .MassageFeature),
            .domain(target: .MassageDomain, type: .testing),
            .domain(target: .UserDomain, type: .testing)
        ]),
        .demo(module: .feature(.MassageFeature), dependencies: [
            .feature(target: .MassageFeature),
            .domain(target: .MassageDomain, type: .testing),
            .domain(target: .UserDomain, type: .testing)
        ])
    ]
)
