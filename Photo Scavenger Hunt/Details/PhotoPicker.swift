//
//  PhotoPicker.swift
//  Photo Scavenger Hunt
//
//  Created by TaeVon Lewis on 4/2/23.
//

import SwiftUI
import CoreLocation
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var completionHandler: ((UIImage?, CLLocationCoordinate2D?) -> Void)?
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.presentationMode.wrappedValue.dismiss()
            
            var image: UIImage?
            var coordinates: CLLocationCoordinate2D?
            
            if let selectedImage = info[.originalImage] as? UIImage {
                image = selectedImage
                print("Image set.")
            }
            
            if let asset = info[.phAsset] as? PHAsset {
                if let location = asset.location?.coordinate {
                    coordinates = location
                    print("Image coordinates: \(coordinates!)")
                } else {
                    print("No location found for the selected image.")
                }
            } else {
                print("No PHAsset found in the info dictionary.")
            }
            parent.completionHandler?(image, coordinates)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.mediaTypes = ["public.image"]
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
            // No update needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
