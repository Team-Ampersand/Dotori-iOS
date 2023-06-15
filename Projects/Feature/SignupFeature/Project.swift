import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.SignupFeature.rawValue,
    targets: [
        .implements(module: .feature(.SignupFeature), dependencies: [
            .feature(target: .BaseFeature),
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .feature(.SignupFeature), dependencies: [
            .feature(target: .SignupFeature)
        ])
    ]
)
