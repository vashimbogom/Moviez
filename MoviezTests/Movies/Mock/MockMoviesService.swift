//
//  MockMoviesService.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

@testable import Moviez

final class MockMoviesService: MoviesService {
        
    var movieListResponse: MoviesDataListDTO?
    var movieDetailsResponse: MovieDetailDTO?
    var error: Error?
    
    func fetchTrendingMoviesList() async throws -> MoviesDataListDTO {
        if let error {
            throw error
        }
        return movieListResponse!
    }
    
    func fetchMovieDetail(movieID: Int) async throws -> Moviez.MovieDetailDTO {
        if let error {
            throw error
        }
        return movieDetailsResponse!
    }
}
