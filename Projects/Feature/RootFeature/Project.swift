import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Feature.RootFeature.rawValue,
    product: .staticLibrary,
    targets: [],
    internalDependencies: [
        .feature(target: .SigninFeature),
        .feature(target: .MainTabFeature),
        .feature(target: .BaseFeature)
    ]
)
