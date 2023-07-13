import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.HomeFeature.rawValue,
    targets: [
        .implements(
            module: .feature(.HomeFeature),
            dependencies: [
                .feature(target: .BaseFeature),
                .domain(target: .AuthDomain, type: .interface),
                .core(target: .Timer, type: .interface)
            ]
        ),
        .tests(
            module: .feature(.HomeFeature),
            dependencies: [
                .feature(target: .HomeFeature),
                .core(target: .Timer, type: .testing)
            ]
        ),
        .demo(
            module: .feature(.HomeFeature),
            dependencies: [
                .feature(target: .HomeFeature),
                .core(target: .Timer, type: .testing)
            ]
        )
    ]
)
