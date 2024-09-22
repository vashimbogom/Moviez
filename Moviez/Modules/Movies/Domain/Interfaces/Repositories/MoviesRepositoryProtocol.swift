//
//  MoviesRepositoryProtocol.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

protocol MoviesRepository {
    func fetchTrendingMoviesList() async throws -> MoviesDataListDTO
}
