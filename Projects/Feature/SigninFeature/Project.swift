import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Feature.SigninFeature.rawValue,
    product: .staticLibrary,
    targets: [.unitTest],
    internalDependencies: [
        .feature(target: .BaseFeature),
        .feature(target: .SignupFeature),
        .feature(target: .RenewalPasswordFeature),
        .domain(target: .AuthDomain, type: .interface)
    ]
)
