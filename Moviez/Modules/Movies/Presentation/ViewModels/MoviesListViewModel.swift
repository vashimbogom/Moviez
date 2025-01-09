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
    func sortMovies()
    func fetchMovies() async
    func searchInFetchedMoviesWithTitleLike(_ searchText: String)
}

final class MoviesListViewModel: MoviesListViewModelProtocol {
    
    @Published var movies: [MovieData] = []
    @Published var isError: Bool = false
    @Published var error: String = ""
    
    var isEmpty: Bool { return movies.isEmpty }
    var pageNumber: Int = 1
    var isSearching = false
    
    private let moviesListUseCase: ShowMoviesListUseCase!
    private var sortAscending = true
    private var fetchedMovies: [MovieData] = []
    
    init(useCase: ShowMoviesListUseCase) {
        self.moviesListUseCase = useCase
    }
    
    @MainActor func fetchMovies() async {
        if isSearching { return }
        do {
            
            let moviesList = try await moviesListUseCase.fetchMoviesList(pageNumber: pageNumber)
            self.movies += moviesList.movies
            self.fetchedMovies = movies
            self.isError = false
            
            pageNumber = 1 + (pageNumber <= moviesList.totalPages ? pageNumber : 0)
        } catch {
            self.isError = true
            if let networkError = error as? ServiceError {
                self.error = networkError.description
            } else {
                self.error = error.localizedDescription
            }
        }
    }
    
    func searchInFetchedMoviesWithTitleLike(_ searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            self.movies = self.fetchedMovies
            isSearching = false
            
        } else {
            isSearching = true
            self.movies = self.fetchedMovies.filter { $0.title.localizedStandardContains(searchText) }
            
        }
    }
    
    func shouldShowLoader() -> Bool {
        (isEmpty && !isError && !isSearching)
    }
    
    func isLastMovie(_ movie: MovieData) -> Bool {
        movies.last?.id == movie.id
    }
    
    func sortMovies() {
        if sortAscending {
            movies = movies.sorted { $0.title < $1.title }
        } else {
            movies = movies.sorted { $0.title > $1.title }
        }
        sortAscending.toggle()
    }
    
}
