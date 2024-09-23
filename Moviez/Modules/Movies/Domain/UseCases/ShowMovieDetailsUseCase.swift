//
//  ShowMovieDetailsUseCase.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

protocol ShowMovieDetailsUseCase {
    func fetchMovieDetails(movieID: Int) async throws -> MovieDetailDTO
}

final class DefaultShowMovieDetailsUseCase: ShowMovieDetailsUseCase {
    
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func fetchMovieDetails(movieID: Int) async throws -> MovieDetailDTO {
        try await repository.fetchMovieDetails(movieID: movieID)
    }
}