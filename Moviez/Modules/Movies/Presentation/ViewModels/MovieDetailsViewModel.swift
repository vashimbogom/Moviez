//
//  MovieDetailsViewModel.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import Foundation

protocol MovieDetailsViewModelProtocol: ObservableObject {

    var movieID: Int {get set}
    var movie: MovieDetail {get set}
    var isError: Bool {get}
    var error: String {get}
    var isEmpty: Bool {get}

    func shouldShowLoader() -> Bool
    func fetchMovieDetails() async
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
        
    @Published var movie: MovieDetail = MovieDetail()
    @Published var isError: Bool = false
    @Published var error: String = ""
    
    var isEmpty: Bool { return movie.id == 0 }
    
    var movieID: Int
    private let movieDetailsUseCase: ShowMovieDetailsUseCase!
    
    init(movieID: Int, useCase: ShowMovieDetailsUseCase) {
        self.movieID = movieID
        self.movieDetailsUseCase = useCase
    }
    
    @MainActor func fetchMovieDetails() async {
        do {
            let movieDetail = try await movieDetailsUseCase.fetchMovieDetails(movieID: self.movieID)
            self.movie = .init(from: movieDetail)
            self.isError = false
        } catch {
            self.isError = true
            if let networkError = error as? ServiceError {
                self.error = networkError.description
            } else {
                self.error = error.localizedDescription
            }
        }
    }

    func shouldShowLoader() -> Bool {
        return (isEmpty && !isError)
    }
}
