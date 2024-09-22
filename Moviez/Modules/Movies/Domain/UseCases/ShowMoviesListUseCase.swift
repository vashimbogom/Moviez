//
//  ShowMoviesListUseCase.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

protocol ShowMoviesListUseCase {
    func fetchMoviesList(pageNumber: Int) async throws -> MoviesDataListDTO
}

extension ShowMoviesListUseCase {
    func fetchMoviesList(pageNumber: Int = 1) async throws -> MoviesDataListDTO {
        try await fetchMoviesList(pageNumber: pageNumber)
    }
}
