//
//  AppConstants.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

struct AppConstants {
    
    enum Movies {
        
        static let localizationTable = "LocalizableMovies"
        
        enum Icons {
            static let errorViewIcon = "exclamationmark.triangle.fill"
            static let moviePlaceholderIcon = "movieclapper"
        }
    }
    
    enum MovieStrings {
        static let trendingMoviesTitle = "Trending movies..."
        static let nowPlayingMoviesTitle = "Now playing"
        
        enum Errors {
            static let title = "Ooops!! Something happened..."
            static let tryAgain = "Please try again"
        }
        
        
    }
    
}
