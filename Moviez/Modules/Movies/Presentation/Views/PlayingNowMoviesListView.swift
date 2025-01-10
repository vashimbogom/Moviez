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
    @State var searchText: String = ""
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
                    MovieErrorView(errorTitle: AppConstants.Movies.Strings.Errors.title, errorDescription: viewModel.error) {
                        Task {
                            await viewModel.fetchMovies()
                        }
                    }
                }
                
            }
            else {
                
                HStack {
                    
                    MoviesText(AppConstants.Movies.Strings.nowPlayingMoviesTitle)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                }
                .padding(.top)
                .padding(.horizontal)
                
                HStack {
                    
                    HStack {
                        Image(systemName: AppConstants.Movies.Icons.searchIcon)
                            .foregroundColor(
                                colorScheme == .dark ? .white : .gray
                            )
                        
                        TextField(text: $searchText) {
                            Text(LocalizedStringResource(String.LocalizationValue(AppConstants.Movies.Strings.search), table: AppConstants.Movies.localizationTable))
                        }
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .font(Font.system(size: 21))
                        .foregroundColor(
                            colorScheme == .dark ? .white : .black
                        )
                        .onChange(of: $searchText.wrappedValue) { _, newValue in
                            self.viewModel.searchInFetchedMoviesWithTitleLike(newValue)
                            
                        }
                        
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: AppConstants.Movies.Icons.clearIcon)
                                .foregroundColor(.secondary)
                        }
                        
                    }
                    .padding(7)
                    .background(
                        colorScheme == .dark ? .gray : .white
                    )
                    .cornerRadius(50)
                    
                    HStack {
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
                        .accessibilityIdentifier(AppConstants.Movies.AccessibilityIdentifiers.sortingMoviesButton)
                        
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
                        .accessibilityIdentifier(AppConstants.Movies.AccessibilityIdentifiers.changeGridLayoutButton)
                    }
                }
                .padding(.bottom)
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
