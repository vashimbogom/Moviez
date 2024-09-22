//
//  MovieEndpoints.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

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
                return "TrendingMoviesListMock.json"
            case .movieDetails(_):
                return "MovieDetailsMock.json"
            case .nowPlayingMovies(_):
                return "NowPlayingMoviesMock.json"

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
            "include_adult" : false,
            "include_video" : false,
            "language" : "en-US"
            
        ]
        
        switch self {
        case .trendingMovies:
            globalParams["sort_by"] = "popularity.desc"
            globalParams["page"] = "1"
        case .movieDetails(_):
            globalParams["language"] = "en-US"
        case .nowPlayingMovies(let pageNumber):
            globalParams["sort_by"] = "popularity.desc"
            globalParams["page"] = "\(pageNumber)"
        }
        
        return globalParams
        
    }
}
