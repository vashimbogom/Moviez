//
//  MoviesListViewModel.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation

protocol MoviesListViewModelProtocol: ObservableObject {
    
    var movies: [MovieData] {get set}
    var isError: Bool {get}
    var error: String {get}
    var isEmpty: Bool {get}
    
    func shouldShowLoader() -> Bool
    func fetchMovies() async
}

final class MoviesListViewModel: MoviesListViewModelProtocol {
    
    @Published var movies: [MovieData] = []
    @Published var isError: Bool = false
    @Published var error: String = ""
    
    var isEmpty: Bool { return movies.isEmpty }
    private var pagenumber: Int = 1
    
    private let moviesListUseCase: ShowMoviesListUseCase!
    
    init(useCase: ShowMoviesListUseCase) {
        self.moviesListUseCase = useCase
    }
    
    @MainActor func fetchMovies() async {
        do {
            
            let moviesList = try await moviesListUseCase.fetchMoviesList(pageNumber: pagenumber)
            self.movies = transformFetchedMovies(movies: moviesList.results)
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
    
    private func transformFetchedMovies(movies: [MovieDataDTO]) -> [MovieData] {
        movies.map { MovieData(from: $0) }
    }
    
    func shouldShowLoader() -> Bool {
        return (isEmpty && !isError)
    }
    
}
