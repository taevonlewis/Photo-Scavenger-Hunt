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
    @Binding var image: UIImage?
    @Binding var imageCoordinates: CLLocationCoordinate2D?
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.presentationMode.wrappedValue.dismiss()
            
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
                print("Image set.")
            }
            
            if let asset = info[.phAsset] as? PHAsset {
                if let coordinates = asset.location?.coordinate {
                    parent.imageCoordinates = coordinates
                    print("Image coordinates: \(coordinates)")
                }
            }
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
