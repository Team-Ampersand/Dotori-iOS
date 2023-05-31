import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Feature.MainTabFeature.rawValue,
    product: .staticLibrary,
    targets: [.unitTest, .demo],
    internalDependencies: [
        .feature(target: .BaseFeature),
        .feature(target: .HomeFeature),
        .feature(target: .NoticeFeature),
        .feature(target: .SelfStudyFeature),
        .feature(target: .MassageFeature),
        .feature(target: .MusicFeature)
    ]
)
