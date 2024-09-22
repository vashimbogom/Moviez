//
//  MoviesDashboardView.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import SwiftUI

struct MoviesDashboardView: View {
    
    private let MoviesContainer = MoviesDIContainer()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    MoviesText(AppConstants.MovieStrings.trendingMoviesTitle)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    MoviesContainer.TrendingMoviesList
                    
                    MoviesText(AppConstants.MovieStrings.nowPlayingMoviesTitle)
                        .font(.title)
                        .fontWeight(.bold)
                    //TODO: - Create Now Playing Grid

                }
                .padding(.vertical)
                
            }
            .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview("EN") {
    MoviesDashboardView()
}

#Preview("ES") {
    MoviesDashboardView()
        .environment(\.locale, Locale(identifier: "es-419"))
}
