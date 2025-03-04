//
//  GalleryView.swift
//  Wallpapers
//
//  Created by Diana Dashinevich on 24/02/2025.
//
import SwiftUI
import Kingfisher

struct GalleryView: View {
    @State private var wallpapers: [Wallpaper] = []
    @State private var selectedTag: String? = nil
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var filteredWallpapers: [Wallpaper] {
        if let tag = selectedTag {
            return wallpapers.filter { $0.tags.contains(tag) }
        }
        return wallpapers
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(filteredWallpapers) { wallpaper in
                            NavigationLink(destination: WallpaperPicView(wallpaper: wallpaper)) {
                                if let url = URL(string: wallpaper.imageUrl) {
                                    KFImage(url)
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                } else {
                                    ProgressView()
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.vertical, 60)
                    .padding(.horizontal, 10)
                }
                .task {
                    await loadWallpapers()
                }
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Button("all") {
                                selectedTag = nil
                            }
                            .padding()
                            .background(selectedTag == nil ? Color.black : Color.gray.opacity(0.8))
                            .foregroundColor(selectedTag == nil ? .white : .black)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            ForEach(uniqueTags(), id: \.self) { tag in
                                Button(tag) {
                                    selectedTag = tag
                                }
                                .padding()
                                .background(selectedTag == tag ? Color.black : Color.gray.opacity(0.8))
                                .foregroundColor(selectedTag == tag ? .white : .black)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    Spacer()
                }
            }
        }
    }
    func loadWallpapers() async {
        do {
            let fetchedWallpapers = try await getPictures()
            DispatchQueue.main.async {
                self.wallpapers = fetchedWallpapers
            }
        } catch {
            print("Failed to load wallpapers: \(error)")
        }
    }
    func uniqueTags() -> [String] {
        let allTags = wallpapers.flatMap { $0.tags }
        return Array(Set(allTags)).sorted()
    }
}


#Preview {
    GalleryView()
}
