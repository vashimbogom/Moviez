//
//  MoviesRepository.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

final class DefaultMoviesRepository: MoviesRepository {
    
    private let service: MoviesService
    
    init(service: MoviesService) {
        self.service = service
    }
    
    func fetchTrendingMoviesList() async throws -> MoviesDataListDTO {
        try await service.fetchTrendingMoviesList()
    }
    
    func fetchMovieDetails(movieID: Int) async throws -> MovieDetailDTO {
        try await service.fetchMovieDetail(movieID: movieID)
    }
}
