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
            static let popularityIcon = "popcorn.fill"
            static let favoriteIcon = "heart.circle"
            static let listGridIcon = "rectangle.grid.1x2.fill"
            static let squareGridIcon = "square.grid.2x2.fill"
        }
        
        enum AnimationIdentifiers {
            static let imageID = "image.id"
            static let titleID = "title.id"
        }
        
        enum Mocks {
            static let imageURL = "https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg"
            static let errorMessage = "Unknown error"
            static let trendingMoviesJSONFile = "TrendingMoviesListMock.json"
            static let movieDetailsJSONFile = "MovieDetailsMock.json"
            static let nowPlayingMoviesJSONFile = "NowPlayingMoviesMock.json"
        }
    }
    
    enum MovieStrings {
        static let title = "Title"
        static let trendingMoviesTitle = "Trending movies..."
        static let nowPlayingMoviesTitle = "Now playing"
        
        static let popularity = "Popularity"
        static let releaseDate = "Release Date"
        static let languages = "Languages"
        static let originalLanguage = "Original Language"
        static let averageVote = "Average Vote"
        static let status = "Status"
        
        
        enum Errors {
            static let title = "Ooops!! Something happened..."
            static let tryAgain = "Please try again"
        }
        
        
    }
    
}
