//
//  ContentView.swift
//  Wallpapers
//
//  Created by Diana Dashinevich on 24/02/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var activeTab: Tab = .gallery
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                switch activeTab {
                case .gallery:
                    GalleryView()
                case .favorites:
                    FavoritesView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            TabbarView(selectedTab: $activeTab)
                .padding(.horizontal, 15)
                .padding(.bottom, 15)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    ContentView()
}
