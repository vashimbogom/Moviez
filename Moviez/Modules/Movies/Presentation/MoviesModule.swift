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
    
}
