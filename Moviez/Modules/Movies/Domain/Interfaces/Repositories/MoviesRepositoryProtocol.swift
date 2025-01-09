//
//  MoviesRepositoryProtocol.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

protocol MoviesRepository {
    func fetchTrendingMoviesList() async throws -> MoviesDataList
    func fetchPlayingNowMoviesList(pageNumber: Int) async throws -> MoviesDataList
    func fetchMovieDetails(movieID: Int) async throws -> MovieDetail
}
