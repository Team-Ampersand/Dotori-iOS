import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Feature.MainTabFeature.rawValue,
    product: .staticLibrary,
    targets: [.unitTest, .demo],
    internalDependencies: [
        .feature(target: .BaseFeature)
    ]
)
