//
//  GalleryManager.swift
//  Wallpapers
//
//  Created by Diana Dashinevich on 26/02/2025.
//
import SwiftUI

func getPictures() async throws -> Gallery {
    let endpoint = "http://localhost:8080/api/v1/wallpapers"
    
    guard let url = URL(string: endpoint) else {
        throw WallpaperError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw WallpaperError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Gallery.self, from: data)
    } catch {
        throw WallpaperError.invalidData
    }
}

struct Wallpaper: Codable, Identifiable {
    let id: String
    let title: String
    let tags: [String]
    let imageUrl: String
    let thumbnailUrl: String
}

typealias Gallery = [Wallpaper]

enum WallpaperError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
