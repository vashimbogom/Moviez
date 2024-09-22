//
//  MockData.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import Foundation
import UIKit

@testable import Moviez

final class MockData {

    static var mockURL = URL(string: "https://api.themoviedb.org/3/discover/movie")!
    
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
}
