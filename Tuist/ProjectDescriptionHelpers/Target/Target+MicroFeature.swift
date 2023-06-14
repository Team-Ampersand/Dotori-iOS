import ConfigurationPlugin
import DependencyPlugin
import EnvironmentPlugin
import ProjectDescription

// MARK: - Interface
public extension Target {
    static func interface(module: ModulePaths, spec: TargetSpec) -> Target {
        spec.toTarget(with: module.targetName(type: .interface), product: .framework)
    }

    static func interface(module: ModulePaths, dependencies: [TargetDependency] = []) -> Target {
        TargetSpec(dependencies: dependencies)
            .toTarget(with: module.targetName(type: .interface), product: .framework)
    }

    static func interface(name: String, spec: TargetSpec) -> Target {
        spec.toTarget(with: "\(name)Interface", product: .framework)
    }

    static func interface(name: String, dependencies: [TargetDependency] = []) -> Target {
        TargetSpec(dependencies: dependencies)
            .toTarget(with: "\(name)Interface", product: .framework)
    }
}

// MARK: - Implements
public extension Target {
    static func implements(
        module: ModulePaths,
        product: Product = .staticLibrary,
        spec: TargetSpec
    ) -> Target {
        spec.toTarget(with: module.targetName(type: .sources), product: product)
    }

    static func implements(
        module: ModulePaths,
        product: Product = .staticLibrary,
        dependencies: [TargetDependency] = []
    ) -> Target {
        TargetSpec(dependencies: dependencies)
            .toTarget(with: module.targetName(type: .sources), product: product)
    }

    static func implements(
        name: String,
        product: Product = .staticLibrary,
        spec: TargetSpec
    ) -> Target {
        spec.toTarget(with: name, product: product)
    }

    static func implements(
        name: String,
        product: Product = .staticLibrary,
        dependencies: [TargetDependency] = []
    ) -> Target {
        TargetSpec(dependencies: dependencies)
            .toTarget(with: name, product: product)
    }
}

// MARK: - Testing
public extension Target {
    static func testing(module: ModulePaths, spec: TargetSpec) -> Target {
        spec.toTarget(with: module.targetName(type: .testing), product: .framework)
    }

    static func testing(module: ModulePaths, dependencies: [TargetDependency] = []) -> Target {
        TargetSpec(dependencies: dependencies)
            .toTarget(with: module.targetName(type: .testing), product: .framework)
    }

    static func testing(name: String, spec: TargetSpec) -> Target {
        spec.toTarget(with: "\(name)Testing", product: .framework)
    }

    static func testing(name: String, dependencies: [TargetDependency] = []) -> Target {
        TargetSpec(dependencies: dependencies)
            .toTarget(with: "\(name)Testing", product: .framework)
    }
}

// MARK: - Tests
public extension Target {
    static func tests(module: ModulePaths, spec: TargetSpec) -> Target {
        spec.toTarget(with: module.targetName(type: .unitTest), product: .unitTests)
    }

    static func tests(module: ModulePaths, dependencies: [TargetDependency] = []) -> Target {
        TargetSpec(dependencies: dependencies)
            .toTarget(with: module.targetName(type: .unitTest), product: .unitTests)
    }

    static func tests(name: String, spec: TargetSpec) -> Target {
        spec.toTarget(with: "\(name)Tests", product: .unitTests)
    }

    static func tests(name: String, dependencies: [TargetDependency] = []) -> Target {
        TargetSpec(dependencies: dependencies)
            .toTarget(with: "\(name)Tests", product: .unitTests)
    }
}

// MARK: - Demo
public extension Target {
    static func demo(module: ModulePaths, spec: TargetSpec) -> Target {
        spec.toTarget(with: module.targetName(type: .demo), product: .app)
    }

    static func demo(module: ModulePaths, dependencies: [TargetDependency] = []) -> Target {
        TargetSpec(dependencies: dependencies)
            .toTarget(with: module.targetName(type: .demo), product: .app)
    }

    static func demo(name: String, spec: TargetSpec) -> Target {
        spec.toTarget(with: "\(name)DemoApp", product: .app)
    }

    static func demo(name: String, dependencies: [TargetDependency] = []) -> Target {
        TargetSpec(dependencies: dependencies)
            .toTarget(with: "\(name)DemoApp", product: .app)
    }
}
