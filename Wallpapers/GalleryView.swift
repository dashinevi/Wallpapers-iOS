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
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(wallpapers) { wallpaper in
                        NavigationLink(destination: WallpaperPicView(wallpaper: wallpaper)) {
                            AsyncImage(url: URL(string: wallpaper.thumbnailUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(10)
            }
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
