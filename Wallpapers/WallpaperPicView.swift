//
//  WallpaperPicView.swift
//  Wallpapers
//
//  Created by Diana Dashinevich on 25/02/2025.
//
import SwiftUI
import Kingfisher
import Photos

struct WallpaperPicView: View {
    let wallpaper: Wallpaper
    let photoSaver = PhotoSaver()
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        ScrollView {
            VStack {
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(wallpaper.tags, id: \.self) { tag in
                            Text(tag)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Capsule())
                                .font(.caption)
                        }
                    }
                }
                .padding(.horizontal)
                
                if let url = URL(string: wallpaper.imageUrl) {
                    KFImage(url)
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(10)
                } else {
                    ProgressView()
                }
                HStack {
                    Button(action: {
                        guard let url = URL(string: wallpaper.imageUrl) else { return }
                        
                        KingfisherManager.shared.retrieveImage(with: url) { result in
                            switch result {
                            case .success(let value):
                                let image = value.image
                                let photoSaver = PhotoSaver()
                                photoSaver.saveImageToGallery(image: image)
                            case .failure(let error):
                                print("Error downloading image: \(error.localizedDescription)")
                            }
                        }
                    }) {
                        Text("Save to Photos")
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    Button(favorites.contains(wallpaper) ? "Remove from Favorites" : "Add to Favorites") {
                                        if favorites.contains(wallpaper) {
                                            favorites.remove(wallpaper)
                                        } else {
                                            favorites.add(wallpaper)
                                        }
                                    }
                                    .padding()
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(.bottom, 70)
            }
        }
        .navigationTitle(wallpaper.title)
        .navigationBarTitleDisplayMode(.inline)
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
    .environmentObject(Favorites())
}
