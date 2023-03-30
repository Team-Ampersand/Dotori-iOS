import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Feature.SigninFeature.rawValue,
    product: .staticLibrary,
    targets: [.interface, .unitTest],
    internalDependencies: [
        .Feature.BaseFeature,
        .Feature.RootFeatureInterface,
        .Feature.SignupFeatureInterface,
        .Feature.RenewalPasswordFeatureInterface,
        .Domain.AuthDomainInterface
    ],
    interfaceDependencies: [
        .SPM.Moordinator
    ]
)
