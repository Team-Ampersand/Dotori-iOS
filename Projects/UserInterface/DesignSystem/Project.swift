import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.UserInterface.DesignSystem.rawValue,
    targets: [
        .implements(
            module: .userInterface(.DesignSystem),
            product: .framework,
            spec: .init(
                resources: ["Resources/**"],
                dependencies: [
                    .SPM.Anim,
                    .SPM.MSGLayout,
                    .userInterface(target: .DWebKit),
                    .shared(target: .GlobalThirdPartyLibrary),
                    .shared(target: .UIKitUtil)
                ]
            )
        ),
        .demo(module: .userInterface(.DesignSystem), dependencies: [
            .userInterface(target: .DesignSystem)
        ])
    ],
    resourceSynthesizers: .default + [
        .custom(name: "Lottie", parser: .json, extensions: ["json"])
    ]
)
