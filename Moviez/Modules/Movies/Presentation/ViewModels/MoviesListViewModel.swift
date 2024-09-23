//
//  MoviesListViewModel.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation

protocol MoviesListViewModelProtocol: ObservableObject {
    
    var movies: [MovieData] {get set}
    var pageNumber: Int {get set}
    var isError: Bool {get}
    var error: String {get}
    var isEmpty: Bool {get}
    
    func shouldShowLoader() -> Bool
    func isLastMovie(_ movie: MovieData) -> Bool 
    func fetchMovies() async
}

final class MoviesListViewModel: MoviesListViewModelProtocol {
    
    @Published var movies: [MovieData] = []
    @Published var isError: Bool = false
    @Published var error: String = ""
    
    var isEmpty: Bool { return movies.isEmpty }
    var pageNumber: Int = 1
    
    private let moviesListUseCase: ShowMoviesListUseCase!
    
    init(useCase: ShowMoviesListUseCase) {
        self.moviesListUseCase = useCase
    }
    
    @MainActor func fetchMovies() async {
        do {
            
            let moviesList = try await moviesListUseCase.fetchMoviesList(pageNumber: pageNumber)
            self.movies += transformFetchedMovies(movies: moviesList.results)
            self.isError = false
            
            pageNumber = 1 + (pageNumber <= moviesList.total_pages ? pageNumber : 0)
        } catch {
            self.isError = true
            if let networkError = error as? ServiceError {
                self.error = networkError.description
            } else {
                self.error = error.localizedDescription
            }
        }
    }
    
    private func transformFetchedMovies(movies: [MovieDataDTO]) -> [MovieData] {
        movies.map { MovieData(from: $0) }
    }
    
    func shouldShowLoader() -> Bool {
        (isEmpty && !isError)
    }
    
    func isLastMovie(_ movie: MovieData) -> Bool {
        movies.last?.id == movie.id
    }
    
}
