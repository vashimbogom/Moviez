//
//  MovieData.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation

struct MovieData: Codable, Identifiable {
    
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String
    let originalLanguage: String
    let releaseDateStr: String
    let popularity: Double
    let voteAverage: Double
}

extension MovieData: MovieDataHelper {
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
