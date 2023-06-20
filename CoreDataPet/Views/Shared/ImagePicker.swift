//
//  ImagePicker.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 15/06/23.
//

import Foundation
import SwiftUI
import Combine

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: Data
    
    func makeCoordinator() -> Coordinator {
        Coordinator(child: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }

}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var child: ImagePicker

    init(child: ImagePicker) {
        self.child = child
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        child.presentationMode.wrappedValue.dismiss()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage]as? UIImage {
            let data = image.jpegData(compressionQuality: 0.45)
            child.selectedImage = data!
        } else {
            return
        }
        child.presentationMode.wrappedValue.dismiss()
    }
}
