//
//  ShowTrendingMoviesUseCase.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

final class DefaultShowTrendingMoviesUseCase: ShowMoviesListUseCase {
    
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func fetchMoviesList(pageNumber: Int = 1) async throws -> MoviesDataList {
        try await repository.fetchTrendingMoviesList()
    }
    
}
