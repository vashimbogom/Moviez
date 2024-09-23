//
//  MovieImageView.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import SwiftUI

struct MovieImageView: View {
    
    let url: URL!
    
    var body: some View {
        CacheAsyncImageView(url: url) { phase in
            
            if EnvironmentConfiguration.appEnvironment == .Mock {
                Image("movie")
                    .resizable()
            }
            else {
                switch(phase) {
                case .empty:
                    ZStack {
                        Image(systemName: AppConstants.Movies.Icons.moviePlaceholderIcon)
                            .font(.system(size: 77))
                            .foregroundColor(.blue)
                        ProgressView()
                            .offset(y:23)
                    }
                    
                case .failure(_):
                    ZStack {
                        Image(systemName: AppConstants.Movies.Icons.moviePlaceholderIcon)
                            .font(.system(size: 77))
                            .foregroundColor(.blue)
                    }
                    
                case .success(let image):
                    image
                        .resizable()
                    
                @unknown default:
                    Image(systemName: AppConstants.Movies.Icons.moviePlaceholderIcon)
                        .font(.system(size: 77))
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    MovieImageView(url: MovieViews_Previews.moviePosterURL)
}
