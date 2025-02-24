//
//  TabbarView.swift
//  Wallpapers
//
//  Created by Diana Dashinevich on 24/02/2025.
//
import SwiftUI

enum Tab: String, CaseIterable, Identifiable {
    case gallery
    case favorites
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .gallery: return ""
        case .favorites: return ""
        }
    }
    
}

struct TabbarView: View {
    @Binding var selectedTab: Tab
    
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.white.opacity(0.9))
                .strokeBorder(Color.secondary,lineWidth: 0.5)
                .frame(height: 70)
                .shadow(radius: 0.5)
               
                
            HStack {
                Spacer()
                Button(Tab.gallery.icon, systemImage: "photo.on.rectangle.angled") {
                    selectedTab = .gallery
                }
                .tint(selectedTab == .gallery ? .primary : .secondary)
                Spacer()
                Button(Tab.favorites.icon, systemImage: "heart.fill") {
                    selectedTab = .favorites
                }
                .tint(selectedTab == .favorites ? .primary : .secondary)
                Spacer()
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedTab: Tab = .gallery
    return TabbarView(selectedTab: $selectedTab)
}
