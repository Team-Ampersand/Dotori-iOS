import ProjectDescription

public extension TargetScript {
    static let swiftLint = TargetScript.pre(
        path: Path.relativeToRoot("Scripts/SwiftLintRunScript.sh"),
        name: "SwiftLint",
        basedOnDependencyAnalysis: false
    )

    static let swiftFormat = TargetScript.pre(
        path: Path.relativeToRoot("Scripts/SwiftFormatRunScript.sh"),
        name: "SwiftFormat",
        basedOnDependencyAnalysis: false
    )
}
