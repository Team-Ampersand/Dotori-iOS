import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Feature.RenewalPasswordFeature.rawValue,
    product: .staticLibrary,
    targets: [.unitTest],
    internalDependencies: [
        .feature(target: .BaseFeature),
        .domain(target: .AuthDomain, type: .interface)
    ]
)
