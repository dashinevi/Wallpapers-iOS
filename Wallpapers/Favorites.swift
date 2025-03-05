//
//  Favorites.swift
//  Wallpapers
//
//  Created by Diana Dashinevich on 05/03/2025.
//

import SwiftUI

class Favorites: ObservableObject {
    @Published private var wallpapers: Set<String>
    private let key = "Favorites"

    init() {
        self.wallpapers = Set(UserDefaults.standard.stringArray(forKey: key) ?? [])
    }

    func contains(_ wallpaper: Wallpaper) -> Bool {
        wallpapers.contains(wallpaper.id)
    }

    func add(_ wallpaper: Wallpaper) {
        wallpapers.insert(wallpaper.id)
        save()
    }

    func remove(_ wallpaper: Wallpaper) {
        wallpapers.remove(wallpaper.id)
        save()
    }

    private func save() {
        UserDefaults.standard.set(Array(wallpapers), forKey: key)
    }
}


