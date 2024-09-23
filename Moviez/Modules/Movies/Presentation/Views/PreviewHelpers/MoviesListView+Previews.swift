//
//  MoviesListView+Previews.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import Foundation
import UIKit

struct MovieViews_Previews {
    
    //MARK: - Movies List
    
    static func getListViewModel() -> MoviesListViewModelMock {
        return MoviesListViewModelMock()
    }
    
    static var moviesData: [MovieData] {
        moviesList
    }
    
    static var moviePosterURL: URL {
        URL(string: AppConstants.Movies.Mocks.imageURL)!
    }
    
    static var moviesList: [MovieData] {
        return domainMovies.map { .init(from: $0) }
    }
    
    static var domainMovies: [MovieDataDTO] {
        return moviesPage.results
    }
    
    static var moviesPage: MoviesDataListDTO {
        try! JSONDecoder().decode( MoviesDataListDTO.self, from: moviesListRawData)
    }
    
    static var moviesListRawData: Data {
        loadJsonData(AppConstants.Movies.Mocks.trendingMoviesJSONFile)
    }
    
    private static func loadJsonData(_ mockFileName: String) -> Data {
        
        if let asset = NSDataAsset(name: mockFileName, bundle: Bundle.main) {
            return asset.data
        }
        return Data()
    }
    
    class MoviesListViewModelMock: MoviesListViewModelProtocol {
        
        var movies: [MovieData] = moviesData
        var pageNumber: Int = 1
        var isEmpty: Bool { return movies.isEmpty }
        var isError: Bool = false
        var error: String = AppConstants.Movies.Mocks.errorMessage
        func fetchMovies() async {}
        func isLastMovie(_ movie: MovieData) -> Bool { false }
        func shouldShowLoader() -> Bool {isEmpty && isError}
    }
}

extension MovieViews_Previews {
    
    //MARK: - Movies Details
    
    static func getMovieDetailsViewModel() -> MovieDetailsViewModelMock {
        return MovieDetailsViewModelMock()
    }
    
    static var movieDetails: MovieDetail {
        return .init(from: movieDetailsDomain)
    }
    
    static var movieDetailsDomain: MovieDetailDTO {
        try! JSONDecoder().decode( MovieDetailDTO.self, from: movieDetailsRawData)
    }
    
    static var movieDetailsRawData: Data {
        loadJsonData(AppConstants.Movies.Mocks.movieDetailsJSONFile)
    }
    
    class MovieDetailsViewModelMock: MovieDetailsViewModelProtocol {

        var movieID: Int = 533535
        var movie: MovieDetail = movieDetails
        var isEmpty: Bool { return false }
        var isError: Bool = false
        var error: String = AppConstants.Movies.Mocks.errorMessage
        
        func fetchMovieDetails() async { }
        func shouldShowLoader() -> Bool {isEmpty && isError}
    }
}
