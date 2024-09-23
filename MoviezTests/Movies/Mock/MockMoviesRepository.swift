//
//  MockMoviesRepository.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

@testable import Moviez

final class MockMoviesRepository: MoviesRepository {

    var moviesListesponse: MoviesDataListDTO?
    var movieDetailsResponse: MovieDetailDTO?
    
    var error: Error?

    func fetchTrendingMoviesList() async throws -> MoviesDataListDTO {
        if let error {
            throw error
        }
        return moviesListesponse!
    }
    
    func fetchPlayingNowMoviesList(pageNumber: Int) async throws -> Moviez.MoviesDataListDTO {
        if let error {
            throw error
        }
        return moviesListesponse!
    }
    
    func fetchMovieDetails(movieID: Int) async throws -> MovieDetailDTO {
        if let error {
            throw error
        }
        return movieDetailsResponse!
    }

}
