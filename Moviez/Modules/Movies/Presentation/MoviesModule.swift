//
//  MoviesModule.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation

final class MoviesModule {

    private let apiDataTransferService: DataTransferService
    
    init(apiDataTransferService: DataTransferService) {
        self.apiDataTransferService = apiDataTransferService
    }
    
    //MARK: - Trending Movies -> Func dependency Approach
    func generateTrendingMoviesListView() -> TrendingMoviesListView<MoviesListViewModel> {
        TrendingMoviesListView(viewModel: generateTrendingMoviesListViewModel())
    }
    
    private func generateTrendingMoviesListViewModel() -> MoviesListViewModel {
        MoviesListViewModel(useCase: generateTrendingMoviesListUseCase())
    }
    
    private func generateTrendingMoviesListUseCase() -> ShowTrendingMoviesUseCase {
        DefaultShowTrendingMoviesUseCase(repository: generateTrendingMoviesListRepository())
    }
    
    private func generateTrendingMoviesListRepository() -> MoviesRepository {
        DefaultMoviesRepository(service: generateMoviesService())
    }
    
    private func generateMoviesService() -> MoviesService {
        DefaultMoviesService(apiDataService: apiDataTransferService)
    }
    
    //MARK: - Movie Details -> Router like property Aproach
    func generateMovieDetailsView(movieID: Int) -> MovieDetailView<MovieDetailsViewModel> {
        
        let service = DefaultMoviesService(apiDataService: apiDataTransferService)
        let repository = DefaultMoviesRepository(service: service)
        let useCase = DefaultShowMovieDetailsUseCase(repository: repository)
        let viewModel = MovieDetailsViewModel(movieID: movieID, useCase: useCase)
        
        return MovieDetailView(viewModel: viewModel)
    }
    
}
