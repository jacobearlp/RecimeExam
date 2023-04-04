//
//  AppCachedAsyncImage.swift
//  RecimeExam
//
//  Created by Jacob on 4/4/23.
//

import SwiftUI
import CachedAsyncImage

struct AppCachedAsyncImage<Content, Placeholder>: View where Content: View, Placeholder: View {
    let url: URL
    let urlCache: URLCache = .shared
    @ViewBuilder var content: (Image) -> Content
    @ViewBuilder let placeholder: Placeholder

    public var body: some View {
        CachedAsyncImage(url: url, urlCache: urlCache) { image in
            content(image)
        } placeholder: {
            placeholder
        }
    }
}

//
// Custom URLCache instances
//
extension URLCache {
    static private let allowedDiskCapacity = 10*1024*1024*1024  // 10G
    static private let allowedMemCapacity = 512*1024*1024       // 512M
    static let DCURLCacheMemAndDisk = URLCache(memoryCapacity: allowedMemCapacity, diskCapacity: allowedDiskCapacity)
    static let DCURLCacheMemOnly = URLCache(memoryCapacity: allowedMemCapacity, diskCapacity: 0)
    static let DCURLCacheDiskOnly = URLCache(memoryCapacity: 0, diskCapacity: allowedDiskCapacity)
}

struct AppCachedAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AppCachedAsyncImage(url: Constants.burgerImageURL) { image in
            image
                .resizable()
                .frame(width: 100, height: 150)
                .scaledToFill()
                .background(.blue)
        } placeholder: {
            ProgressView()
                .frame(width: 100, height: 150)
        }
    }
}
