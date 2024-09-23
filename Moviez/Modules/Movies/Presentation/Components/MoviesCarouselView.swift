//
//  MoviesCarouselView.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import SwiftUI

struct MoviesCarouselView: View {
    
    @State var index = 0
    @Binding var movies: [MovieData]
    private let MoviesContainer = MoviesDIContainer()
    
    var body: some View {
        TabView(selection: self.$index) {
            ForEach(0..<self.movies.count, id: \.self) { index in
                
                NavigationLink {
                    
                    MoviesContainer.getMovieDetailsView(movieID: self.movies[index].id)
                    
                } label: {
                    
                    ZStack {
                        
                        MovieImageView(url: URL(string: self.movies[index].imageURL))
                            .aspectRatio(contentMode: .fill)
                            .frame(height: self.index == index ? 230 : 180)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .tag(index)
                            .accessibilityIdentifier(AppConstants.Movies.AccessibilityIdentifiers.carouselMovieImage)
                        
                        Text(self.movies[index].title)
                            .fontWeight(.black)
                            .foregroundColor(.black)
                            .frame(width: 200, height: 27)
                            .padding()
                            .padding(.horizontal, 25)
                            .background(.white.opacity(0.77))
                            .cornerRadius(10)
                            .offset(x:50, y:45)
                        
                    }
                }
                
            }
        }
        .frame(height: 230)
        .tabViewStyle(PageTabViewStyle())
        .animation(.easeOut(duration: 1), value: true)
    }
}

#Preview {
    MoviesCarouselView(movies: .constant(MovieViews_Previews.moviesData))
}
