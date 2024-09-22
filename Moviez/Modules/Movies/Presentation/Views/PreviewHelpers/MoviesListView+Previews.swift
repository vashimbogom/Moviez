//
//  MoviesListView+Previews.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import Foundation
import UIKit

struct MovieViews_Previews {
    
    static func getListViewModel() -> MoviesListViewModelMock {
        return MoviesListViewModelMock()
    }
    
    static var moviesData: [MovieData] {
        Array(moviesList.prefix(3))
    }
    
    static var moviePosterURL: URL {
        URL(string: "https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg")!
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
        loadJsonData("TrendingMoviesListMock.json")
    }
    
    private static func loadJsonData(_ mockFileName: String) -> Data {
        
        if let asset = NSDataAsset(name: mockFileName, bundle: Bundle.main) {
            return asset.data
        }
        return Data()
    }
    
    class MoviesListViewModelMock: MoviesListViewModelProtocol {
        
        var movies: [MovieData] = moviesData
        var isEmpty: Bool { return movies.isEmpty }
        var isError: Bool = false
        var error: String = "Error"
        func fetchMovies() async {}
        func shouldShowLoader() -> Bool {isEmpty && isError}
    }
    
}
