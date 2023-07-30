import BaseFeatureInterface
import InputDialogFeatureInterface

final class InputDialogFactoryImpl: InputDialogFactory {
    func makeViewController(
        title: String,
        placeholder: String,
        inputType: DialogInputType,
        confirmAction: @escaping (String) async -> Void
    ) -> any RoutedViewControllable {
        let store = InputDialogStore(
            inputType: inputType,
            confirmAction: confirmAction
        )
        return InputDialogViewController(title: title, placeholder: placeholder, store: store)
    }
}
