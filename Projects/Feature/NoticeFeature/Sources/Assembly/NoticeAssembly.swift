import Swinject

final class NoticeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NoticeFactory.self) { _ in
            NoticeFactoryImpl()
        }
    }
}
