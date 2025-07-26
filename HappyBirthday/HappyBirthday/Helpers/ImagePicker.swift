//
//  ImagePicker.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import SwiftUI
import UIKit

/// A SwiftUI wrapper for UIKit's `UIImagePickerController`,
/// allowing the user to pick an image from the camera or photo library.
struct ImagePicker: UIViewControllerRepresentable {
    
    /// The source type: `.camera` or `.photoLibrary`
    let sourceType: UIImagePickerController.SourceType
    
    /// Callback when the user picks an image
    let onImagePicked: (UIImage) -> Void
    
    /// Used to dismiss the picker view
    @Environment(\.dismiss) private var dismiss

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    /// Coordinator acts as delegate for `UIImagePickerController`
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.onImagePicked(image)
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

