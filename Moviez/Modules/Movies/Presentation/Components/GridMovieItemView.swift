//
//  GridMovieItemView.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import SwiftUI
import SwiftData

struct GridMovieItemView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteMovies: [FavoriteMovie]
    
    var movie: MovieData
    let itemWidth = (UIScreen.main.bounds.width-50) / 2
    
    @Binding var columns: [GridItem]
    @Namespace var namespace
    
    var body: some View {
        
        if self.columns.count == 2 {
            VStack(spacing: 5) {
                
                ZStack {
                    MovieImageView(url: URL(string: movie.imageURL))
                        .frame(width: itemWidth, height: 250)
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fit)
                    
                    HStack {
                        Spacer()
                        Image(systemName: AppConstants.Movies.Icons.favoriteIcon)
                            .font(.system(size: 30))
                            .foregroundColor(favoriteMovies.contains {
                                $0.movieId  == movie.id
                            } ? .red : .gray)
                            .padding(.all, 2)
                            .background(Color.white)
                            .cornerRadius(10)
                            .offset(x:5, y:-10)
                    }
                    .offset(y:-100)
                    
                }
                .frame(width: itemWidth, height: 250)
                .matchedGeometryEffect(id: AppConstants.Movies.AnimationIdentifiers.imageID, in: self.namespace)
                
                Text(movie.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .frame(width: itemWidth, height: 21)
                    .matchedGeometryEffect(id: AppConstants.Movies.AnimationIdentifiers.titleID, in: self.namespace)
                
            }
            
        }
        else {
            
            HStack(spacing: 15) {
                ZStack {
                    
                    MovieImageView(url: URL(string: movie.imageURL))
                        .frame(width: itemWidth, height: 250)
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fit)
                    
                }
                .frame(width: itemWidth, height: 250)
                .matchedGeometryEffect(id: AppConstants.Movies.AnimationIdentifiers.imageID, in: self.namespace)
                
                VStack {
                    
                    HStack {
                        Spacer()
                        Image(systemName: AppConstants.Movies.Icons.favoriteIcon)
                            .font(.system(size: 50))
                            .foregroundColor(favoriteMovies.contains {
                                $0.movieId  == movie.id
                            } ? .red : .gray)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(10)
                            .offset(y:-10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: AppConstants.Movies.AnimationIdentifiers.titleID, in: self.namespace)
                        
                        MoviesText(AppConstants.MovieStrings.originalLanguage)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top,1)
                        Text(movie.originalLanguage)
                            .foregroundColor(.accentColor)
                        
                        MoviesText(AppConstants.MovieStrings.popularity)
                        .foregroundColor(.gray)
                        .padding(.top,3)
                        .padding(.bottom,3)
                        
                        MoviePopularityView(rate: movie.popularityIndex)
                    }
                    
                    Spacer()
                }
                .frame(width: itemWidth, height: 250)
                
            }
        }
        
    }
}

#Preview("Single-Col") {
    GridMovieItemView(movie: MovieViews_Previews.moviesData.first!, columns: .constant(
        [GridItem(.flexible(), spacing: 13)
        ]))
}

#Preview("Two-Col") {
    GridMovieItemView(movie: MovieViews_Previews.moviesData.first!, columns: .constant(
        [GridItem(.flexible(), spacing: 13),
         GridItem(.flexible(), spacing: 13)
        ]))
}
