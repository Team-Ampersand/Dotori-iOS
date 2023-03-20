import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let MSGLayout = TargetDependency.external(name: "MSGLayout")
    static let Swinject = TargetDependency.external(name: "Swinject")
}

public extension Package {
}
