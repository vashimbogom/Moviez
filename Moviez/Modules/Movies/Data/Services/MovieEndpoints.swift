//
//  MovieEndpoints.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//
import Foundation

enum MovieEndpoints {
    case trendingMovies
    case nowPlayingMovies(pageNumber: Int)
    case movieDetails(movieId: String)
}

extension MovieEndpoints: Endpoint {
    
    var path: String {
        if EnvironmentConfiguration.appEnvironment != .Mock {
            switch self {
            case .trendingMovies:
                return "/3/discover/movie"
            case .movieDetails(let movieId):
                return "/3/movie/\(movieId)"
            case .nowPlayingMovies(_):
                return "/3/movie/now_playing"

            }
        } else {
            switch self {
            case .trendingMovies:
                return AppConstants.Movies.Mocks.trendingMoviesJSONFile
            case .movieDetails(_):
                return AppConstants.Movies.Mocks.movieDetailsJSONFile
            case .nowPlayingMovies(_):
                return AppConstants.Movies.Mocks.nowPlayingMoviesJSONFile

            }
        }
    }

    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : String]? {
        [
            "accept": "application/json",
            "Authorization": "Bearer \(EnvironmentConfiguration.movieDBAPIToken)"
        ]
    }

    var params: [String: Any]? {
        
        var globalParams: [String: Any] = [
            "include_video" : false
        ]
        
        switch self {
        case .trendingMovies:
            globalParams["include_adult"] = false
            globalParams["sort_by"] = "popularity.desc"
            globalParams["page"] = "1"
        case .movieDetails(_):
            globalParams["include_video"] = false
        case .nowPlayingMovies(let pageNumber):
            globalParams["include_adult"] = false
            globalParams["sort_by"] = "popularity.desc"
            globalParams["page"] = "\(pageNumber)"
        }
        
        if let langCode = Locale.current.language.languageCode?.identifier.lowercased(), langCode.contains("en") {
            globalParams["language"] = "en-US"
        } else {
            globalParams["language"] = "es-MX"
        }
        
        
        return globalParams
        
    }
}
