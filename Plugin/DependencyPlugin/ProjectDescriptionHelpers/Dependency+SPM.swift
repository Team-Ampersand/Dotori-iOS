import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let YPImagePicker = TargetDependency.external(name: "YPImagePicker")
    static let Lottie = TargetDependency.external(name: "Lottie")
    static let Nuke = TargetDependency.external(name: "Nuke")
    static let Anim = TargetDependency.external(name: "Anim")
    static let CombineMiniature = TargetDependency.external(name: "CombineMiniature")
    static let AsyncNeiSwift = TargetDependency.external(name: "AsyncNeiSwift")
    static let Inject = TargetDependency.external(name: "Inject")
    static let GRDB = TargetDependency.external(name: "GRDB")
    static let IQKeyboardManagerSwift = TargetDependency.external(name: "IQKeyboardManagerSwift")
    static let Store = TargetDependency.external(name: "Store")
    static let Moordinator = TargetDependency.external(name: "Moordinator")
    static let Emdpoint = TargetDependency.external(name: "Emdpoint")
    static let MSGLayout = TargetDependency.external(name: "MSGLayout")
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let Configure = TargetDependency.external(name: "Configure")
}

public extension Package {
}
