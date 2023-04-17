import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Feature.RootFeature.rawValue,
    product: .staticLibrary,
    targets: [],
    internalDependencies: [
        .Feature.SigninFeatureInterface,
        .Feature.MainFeatureInterface,
        .Feature.BaseFeature
    ],
    interfaceDependencies: [
        .SPM.Moordinator
    ]
)
