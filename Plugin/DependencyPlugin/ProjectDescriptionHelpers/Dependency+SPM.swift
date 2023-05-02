import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let Moordinator = TargetDependency.external(name: "Moordinator")
    static let Emdpoint = TargetDependency.external(name: "Emdpoint")
    static let MSGLayout = TargetDependency.external(name: "MSGLayout")
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let Configure = TargetDependency.external(name: "Configure")
}

public extension Package {
}
