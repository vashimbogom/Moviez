//
//  ShowTrendingMoviesUseCase.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

protocol ShowTrendingMoviesUseCase: ShowMoviesListUseCase {
    func fetchTrendingMoviesList() async throws -> MoviesDataListDTO
}

final class DefaultShowTrendingMoviesUseCase: ShowTrendingMoviesUseCase {
    
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func fetchMoviesList(pageNumber: Int = 1) async throws -> MoviesDataListDTO {
        try await fetchTrendingMoviesList()
    }
    
    func fetchTrendingMoviesList() async throws -> MoviesDataListDTO {
        try await repository.fetchTrendingMoviesList()
    }
}
