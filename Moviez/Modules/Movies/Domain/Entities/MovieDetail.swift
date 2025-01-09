//
//  MovieDetail.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import Foundation

struct MovieDetail: Decodable, Identifiable {
    
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String
    let originalLanguage: String
    let releaseDateStr: String
    let popularity: Double
    let voteAverage: Double
    let genres: [MovieGenre]
    let spokenLanguages: [SpokenLanguage]
    let status: String
    
    init(
        id: Int = 0,
        title: String = "",
        originalTitle: String = "",
        overview: String = "",
        posterPath: String = "",
        originalLanguage: String = "",
        releaseDateStr: String = "",
        popularity: Double = 0,
        voteAverage: Double = 0,
        genres: [MovieGenre] = [],
        spokenLanguages: [SpokenLanguage] = [],
        status: String = "")
    {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.originalLanguage = originalLanguage
        self.releaseDateStr = releaseDateStr
        self.popularity = popularity
        self.voteAverage = voteAverage
        self.genres = genres
        self.spokenLanguages = spokenLanguages
        self.status = status
    }
}

extension MovieDetail: MovieDataHelper {
    var popularityIndex: Int {
        getPopularityIndex(popularity: popularity)
    }
    
    var releaseDate: Date {
        getReleaseDate(dateStr: releaseDateStr)
    }
    
    var imageURL: String {
        getImageURL(posterPath: posterPath)
    }
}
