//
//  FavoritesView.swift
//  Wallpapers
//
//  Created by Diana Dashinevich on 24/02/2025.
//
import SwiftUI
import Kingfisher

struct FavoritesView: View {
    @EnvironmentObject var favorites: Favorites
    @State private var wallpapers: [Wallpaper] = []

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(wallpapers) { wallpaper in
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
                .padding()
            }
            .navigationTitle("Favorites")
            .onAppear {
                loadFavorites()
            }
        }
    }

    private func loadFavorites() {
        Task {
            let allWallpapers = try await getPictures()
            DispatchQueue.main.async {
                self.wallpapers = allWallpapers.filter { favorites.contains($0) }
            }
        }
    }
}

