//
//  ShowPlayingNowMoviesUseCase.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

protocol ShowPlayingNowMoviesUseCase: ShowMoviesListUseCase {
    func fetchPlayingNowMoviesList(pageNumber: Int) async throws -> MoviesDataListDTO
}

final class DefaultShowPlayingNowMoviesUseCase: ShowPlayingNowMoviesUseCase {
    
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func fetchMoviesList(pageNumber: Int = 1) async throws -> MoviesDataListDTO {
        try await fetchPlayingNowMoviesList(pageNumber: pageNumber)
    }
    
    func fetchPlayingNowMoviesList(pageNumber: Int) async throws -> MoviesDataListDTO {
        try await repository.fetchPlayingNowMoviesList(pageNumber: pageNumber)
    }
}
