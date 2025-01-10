//
//  TrendingMoviesListView.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import SwiftUI

struct TrendingMoviesListView<ViewModel>: View where ViewModel: MoviesListViewModelProtocol {
    
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        LazyVStack {
            
            if viewModel.shouldShowLoader() {
                
                ProgressView()
                    .progressViewStyle(.circular)
                
            } else if viewModel.isError {
                
                HStack {
                    MovieErrorView(
                        errorTitle: AppConstants.Movies.Strings.Errors.title,
                        errorDescription: viewModel.error
                    ) {
                        Task {
                            await viewModel.fetchMovies()
                        }
                    }
                }
                
            } else {
                
                MoviesCarouselView(movies: self.$viewModel.movies)
                
            }
        }
        .task {
            await viewModel.fetchMovies()
        }
        
    }
}

#Preview {
    TrendingMoviesListView(viewModel: MovieViews_Previews.getListViewModel())
}
