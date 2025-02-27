//
//  WallpaperPicView.swift
//  Wallpapers
//
//  Created by Diana Dashinevich on 25/02/2025.
//
import SwiftUI

struct WallpaperPicView: View {
    let wallpaper: Wallpaper
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    //                Text(wallpaper.title)
                    //                    .font(.headline)
                    //                    .foregroundColor(.primary)
                    //
                    HStack {
                        ForEach(wallpaper.tags, id: \.self) { tag in
                            Text(tag)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Capsule())
                                .font(.caption)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    AsyncImage(url: URL(string: wallpaper.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding()
                            
                    } placeholder: {
                        ProgressView()
                    }
                    
                }
            }
            .navigationBarTitle(wallpaper.title)
        }
    }
}




#Preview {
    WallpaperPicView(
        wallpaper: Wallpaper(
            id: "1",
            title: "Sunset",
            tags: ["nature", "sunset", "beautiful"],
            imageUrl: "https://example.com/image.jpg",
            thumbnailUrl: "https://example.com/thumb.jpg"
        )
    )
}
