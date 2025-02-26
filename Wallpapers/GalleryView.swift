//
//  GalleryView.swift
//  Wallpapers
//
//  Created by Diana Dashinevich on 24/02/2025.
//
import SwiftUI

struct GalleryView: View {
    @State private var wallpapers: Gallery = []
    
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(wallpapers) { wallpaper in
                    AsyncImage(url: URL(string: wallpaper.thumbnailUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(20)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            .padding()
            .task {
                do {
                    wallpapers = try await getPictures()
                } catch {
                    print("Failed to load wallpapers: \(error)")
                }
            }
        }
    }
}

#Preview {
    GalleryView()
}
