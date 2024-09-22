//
//  MockShowMovieDetailsUseCase.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

@testable import Moviez

class MockShowMovieDetailsUseCase: ShowMovieDetailsUseCase {
    
    var response: MovieDetailDTO?
    var error: Error?
    
    func fetchMovieDetails(movieID: Int) async throws -> MovieDetailDTO {
        if let error {
            throw error
        }
        return response!
    }

}
