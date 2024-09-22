//
//  MoviesService.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

protocol MoviesService {
    func fetchTrendingMoviesList() async throws -> MoviesDataListDTO
    func fetchMovieDetail(movieID: Int) async throws -> MovieDetailDTO
}

final class DefaultMoviesService: MoviesService {
    private let apiDataService: DataTransferService
    
    init(apiDataService: DataTransferService) {
        self.apiDataService = apiDataService
    }
    
    func fetchTrendingMoviesList() async throws -> MoviesDataListDTO {
        try await apiDataService.request(for: MovieEndpoints.trendingMovies)
    }
    
    func fetchMovieDetail(movieID: Int) async throws -> MovieDetailDTO {
        try await apiDataService.request(for: MovieEndpoints.movieDetails(movieId: "\(movieID)"))
    }
}
