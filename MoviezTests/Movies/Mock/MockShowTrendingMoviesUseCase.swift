//
//  MockShowTrendingMoviesUseCase.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

@testable import Moviez

class MockShowTrendingMoviesUseCase: ShowTrendingMoviesUseCase {
    
    var response: MoviesDataListDTO?
    var error: Error?
    
    func fetchMoviesList(pageNumber: Int) async throws -> MoviesDataListDTO {
        if let error {
            throw error
        }
        return response!
    }

    func fetchTrendingMoviesList() async throws -> MoviesDataListDTO {
        if let error {
            throw error
        }
        return response!
    }

}
