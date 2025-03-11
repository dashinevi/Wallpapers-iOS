# Wallpaper Catalog App

## Overview
Wallpaper Catalog is an application that allows users to browse, favorite, and save wallpapers to their photo library. 

## Features  
- Add or remove wallpapers from your favorites.  
- Download and store wallpapers in your photo library.  
- Find wallpapers by selecting tags.   

## Technical Specifications  
- **Language**: Swift  
- **Framework**: SwiftUI  
- **Networking**: Uses `URLSession` with async/await to fetch wallpapers from an API.  
- **Image Handling**: `Kingfisher` library for image loading and caching.  
- **Local Storage**: `UserDefaults` for saving favorite wallpapers.  
- **Permissions**: Requests `PHPhotoLibrary` access for saving images.   

