import Foundation
import SwiftUI

struct ImagePickerViewBB: UIViewControllerRepresentable {
    @Binding var showImagePicker: Bool
    var completionHandler: (UIImage?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerViewBB

        init(_ parent: ImagePickerViewBB) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                parent.completionHandler(pickedImage)
            } else {
                parent.completionHandler(nil)
            }
            parent.showImagePicker = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.completionHandler(nil)
            parent.showImagePicker = false
        }
    }
}


struct CameraPickerView: UIViewControllerRepresentable {
    @Binding var showImagePicker: Bool
    var completionHandler: (UIImage?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .camera // Зміна джерела на камеру
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPickerView

        init(_ parent: CameraPickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                parent.completionHandler(pickedImage)
            } else {
                parent.completionHandler(nil)
            }
            parent.showImagePicker = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.completionHandler(nil)
            parent.showImagePicker = false
        }
    }
}
