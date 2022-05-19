//
//  PhotoSelectorView.swift
//  Union_Forums
//
//  Created by Adam Long on 5/12/22.
//

import SwiftUI
import PhotosUI

struct PhotoSelectorView: UIViewControllerRepresentable
{
    @Binding var picker: Bool
    @Binding var imgData: Data
    
    
    func makeCoordinator() -> PhotosPickerViewCoordinator
    {
        return PhotoSelectorView.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some PHPickerViewController
    {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .any(of: [.images])//.video is an option
        configuration.selectionLimit = 1
        
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context)
    {
     //the fuck do I know what this does.
    }
    
}

class PhotosPickerViewCoordinator: NSObject, PHPickerViewControllerDelegate
{
    var parent: PhotoSelectorView
    
    init(parent: PhotoSelectorView)
    {
        self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult])
    {
        if results.isEmpty
        {
            self.parent.picker.toggle()
            return
        }
        
        let item = results.first!.itemProvider
        
        if item.canLoadObject(ofClass: UIImage.self)
        {
            item.loadObject(ofClass: UIImage.self)
            {(image, err) in
                if err != nil {return}
                
                let imageData = image as! UIImage
                
                DispatchQueue.main.async {
                    self.parent.imgData = imageData.jpegData(compressionQuality: 0.5)!
                    
                    self.parent.picker.toggle()
                }
                
            }
        }
    }
}
