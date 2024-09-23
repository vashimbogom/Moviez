//
//  PlayingNowMoviesListView.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import SwiftUI

struct PlayingNowMoviesListView<ViewModel>: View where ViewModel: MoviesListViewModelProtocol {
    
    @ObservedObject private var viewModel: ViewModel
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 13), count: 2)
    @Environment(\.colorScheme) var colorScheme
    
    private let MovieContainer = MoviesDIContainer()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        LazyVStack {
            
            if viewModel.shouldShowLoader() {
                
                ProgressView()
                    .progressViewStyle(.circular)
                
            }
            else if viewModel.isError {
                
                HStack {
                    MovieErrorView(errorTitle: AppConstants.MovieStrings.Errors.title, errorDescription: viewModel.error) {
                        Task {
                            await viewModel.fetchMovies()
                        }
                    }
                }
                
            }
            else {
                
                HStack {
                    
                    MoviesText(AppConstants.MovieStrings.nowPlayingMoviesTitle)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        
                        withAnimation(.easeInOut) {
                            viewModel.sortMovies()
                        }
                        
                    } label: {
                        Image(
                            systemName: AppConstants.Movies.Icons.sortingIcon
                        )
                        .font(.system(size: 25))
                        .foregroundColor(colorScheme == .dark ? .accentColor : .black)
                    }
                    
                    Button {
                        
                        withAnimation(.easeOut) {
                            if self.columns.count == 2 {
                                self.columns.removeLast()
                            } else {
                                self.columns.append(GridItem(.flexible(), spacing: 15))
                            }
                        }
                        
                    } label: {
                        Image(
                            systemName: self.columns.count == 2 ?
                            AppConstants.Movies.Icons.listGridIcon
                            : AppConstants.Movies.Icons.squareGridIcon
                        )
                        .font(.system(size: self.columns.count == 2 ? 23 : 25))
                        .foregroundColor(colorScheme == .dark ? .accentColor : .black)
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(self.viewModel.movies) { movie in
                        
                        NavigationLink {
                            
                            MovieContainer.getMovieDetailsView(movieID: movie.id)
                            
                        } label: {
                            
                            GridMovieItemView(movie: movie, columns: self.$columns)
                                .background(
                                    colorScheme == .dark ?
                                    (self.columns.count == 2) ?
                                        .clear : Color(cgColor: CGColor(red: 41/255, green: 42/255, blue: 48.0/255, alpha: 1))
                                    : (self.columns.count == 2) ?
                                        .clear : .white
                                )
                                .task {
                                    if self.viewModel.isLastMovie(movie) {
                                        await viewModel.fetchMovies()
                                    }
                                }
                        }
                    }
                }
                .padding([.horizontal, .bottom])
                
            }
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
}

#Preview {
    PlayingNowMoviesListView(viewModel: MovieViews_Previews.getListViewModel())
}
