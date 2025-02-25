//
//  GalleryView.swift
//  Wallpapers
//
//  Created by Diana Dashinevich on 24/02/2025.
//
import SwiftUI

struct GalleryView: View {
    let galleryPics = ["Image 1", "Image 2", "Image 3"]
    
    let columns = [
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20)
        ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: columns, spacing: 10) {
               
                    ForEach(galleryPics, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(20)
                    }
            }
            .padding()
        }
    }
}

#Preview {
    GalleryView()
}
