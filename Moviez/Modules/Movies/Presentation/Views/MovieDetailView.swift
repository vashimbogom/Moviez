//
//  MovieDetailView.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import SwiftUI
import SwiftData

struct MovieDetailView<ViewModel>: View where ViewModel: MovieDetailsViewModelProtocol {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteMovies: [FavoriteMovie]
    
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            
            if viewModel.shouldShowLoader() {
                
                ProgressView()
                    .progressViewStyle(.circular)
                
            }
            else if viewModel.isError {
                
                HStack {
                    MovieErrorView(errorTitle: AppConstants.Movies.Strings.Errors.title, errorDescription: viewModel.error) {
                        Task {
                            await viewModel.fetchMovieDetails()
                        }
                    }
                }
                
            }
            else {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        
                        Text(viewModel.movie.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .trailing])
                            .accessibilityIdentifier(AppConstants.Movies.AccessibilityIdentifiers.movieDetailTitle)
                        
                        ZStack {
                            MovieImageView(url: URL(string: viewModel.movie.imageURL))
                                .frame(width:210, height: 300)
                                .cornerRadius(20)
                                .aspectRatio(contentMode: .fit)
                            
                            HStack{
                                Spacer()
                                Button {
                                    favoriteMovie()
                                } label: {
                                    Image(systemName: AppConstants.Movies.Icons.favoriteIcon)
                                        .font(.system(size: 60))
                                        .foregroundColor(favoriteMovies.contains {
                                            $0.movieId  == viewModel.movie.id
                                        } ? .red : .gray)
                                        .padding(.all, 2)
                                        .background(Color.white)
                                        .cornerRadius(15)
                                }
                            }
                            .frame(width: 230)
                            
                        }
                        
                        HStack(spacing: 5) {
                            ForEach(viewModel.movie.genres) { genre in
                                Text(genre.name)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Text(viewModel.movie.overview)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        HMovieLabelView(title: AppConstants.Movies.Strings.popularity, description: "\(viewModel.movie.popularity)")
                        MoviePopularityView(rate: viewModel.movie.popularityIndex)
                        
                        HMovieLabelView(title: AppConstants.Movies.Strings.releaseDate, description: viewModel.movie.releaseDateStr)
                        
                        Text(
                            LocalizedStringResource(
                                String.LocalizationValue(AppConstants.Movies.Strings.languages),
                                table: AppConstants.Movies.localizationTable)
                        )
                        .font(.footnote)
                        .foregroundColor(.gray)
                        
                        HStack(spacing: 5) {
                            ForEach(viewModel.movie.spokenLanguages, id:\.self) { language in
                                Text(language.name)
                                    .foregroundColor(.accentColor)
                            }
                        }
                        
                        HMovieLabelView(title: AppConstants.Movies.Strings.averageVote, description: "\(viewModel.movie.voteAverage)")
                        
                        HMovieLabelView(title: AppConstants.Movies.Strings.status, description: viewModel.movie.status)
                        
                        
                        Spacer()
                    }
                }
                .padding()
            }
        }
        .task {
            await viewModel.fetchMovieDetails()
        }
        
    }
    
    private func favoriteMovie() {
        
        if favoriteMovies.contains(where: {$0.movieId == viewModel.movie.id}) {
            if let favMovie = favoriteMovies.first(where: { $0.movieId == viewModel.movie.id }) {
                modelContext.delete(favMovie)
            }
        } else {
            let favMovie = FavoriteMovie(movieId: viewModel.movie.id)
            modelContext.insert(favMovie)
        }
    }
}

#Preview {
    MovieDetailView(viewModel: MovieViews_Previews.getMovieDetailsViewModel())
        .modelContainer(for: FavoriteMovie.self, inMemory: true)
}
