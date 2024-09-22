//
//  CacheAsyncImageView.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import SwiftUI

struct CacheAsyncImageView<Content>: View where Content: View {
    
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(url: URL,
         scale: CGFloat = 1.0,
         transaction: Transaction = Transaction(),
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    var body: some View {
        
        if let cached = ImageCache[url] {
            content(.success(cached))
        } else {
            AsyncImage(url: url, scale: scale, transaction: transaction) { phase in
                if case .success(let image) = phase {
                    ImageCache[url] = image
                }
                return content(phase)
            }
        }
    }
}

#Preview {
    CacheAsyncImageView(url: MovieViews_Previews.moviePosterURL) { phase in
        
        switch(phase) {
        case .empty:
            ProgressView()
        case .failure(_):
            ProgressView()
        case .success(let image):
            image
        @unknown default:
            ProgressView()
        }
    }
}

fileprivate class ImageCache {
    
    static private var cache: [URL:Image] = [:]
    
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
    
}
