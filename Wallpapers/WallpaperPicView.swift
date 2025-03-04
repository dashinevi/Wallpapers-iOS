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
    
    var body: some View {
        NavigationView {
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
                        .padding()
                    } else {
                        ProgressView()
                    }
                }
                .padding(.bottom, 70)
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
