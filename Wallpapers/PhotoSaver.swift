//
//  PhotoSaver.swift
//  Wallpapers
//
//  Created by Diana Dashinevich on 04/03/2025.
//
//

import SwiftUI
import Photos

class PhotoSaver: NSObject {
    func saveImageToGallery(image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                if status == .authorized || status == .limited {
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveCompleted(_:didFinishSavingWithError:contextInfo:)), nil)
                } else {
                    print("Permission denied or restricted")
                }
            }
        }
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving photo: \(error.localizedDescription)")
        } else {
            print("Photo saved successfully!")
        }
    }
}
