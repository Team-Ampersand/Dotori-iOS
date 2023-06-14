import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.UserInterface.DWebKit.rawValue,
    targets: [
        .implements(module: .userInterface(.DWebKit), product: .framework),
        .demo(module: .userInterface(.DWebKit), dependencies: [
            .userInterface(target: .DWebKit)
        ])
    ]
)
