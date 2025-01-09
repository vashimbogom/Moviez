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
    
    func fetchTrendingMoviesList() async throws -> MoviesDataList {
        try await service.fetchTrendingMoviesList().toDomain()
    }
    
    func fetchPlayingNowMoviesList(pageNumber: Int) async throws -> MoviesDataList {
        try await service.fetchPlayingNowMoviesList(pageNumber: pageNumber).toDomain()
    }
    
    func fetchMovieDetails(movieID: Int) async throws -> MovieDetail {
        try await service.fetchMovieDetail(movieID: movieID).toDomain()
    }
}
