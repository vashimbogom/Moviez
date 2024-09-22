//
//  MockMoviesService.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

@testable import Moviez

final class MockMoviesService: MoviesService {
        
    var response: MoviesDataListDTO?
    var error: Error?
    
    func fetchTrendingMoviesList() async throws -> MoviesDataListDTO {
        if let error {
            throw error
        }
        return response!
    }
}
