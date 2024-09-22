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
    
    init(from movieDataDTO: MovieDataDTO) {
        self.id = movieDataDTO.id
        self.title = movieDataDTO.title ?? ""
        self.originalTitle = movieDataDTO.original_title ?? ""
        self.overview = movieDataDTO.overview ?? ""
        self.posterPath = movieDataDTO.poster_path ?? ""
        self.originalLanguage = movieDataDTO.original_language?.uppercased() ?? ""
        self.releaseDateStr = movieDataDTO.release_date ?? ""
        self.popularity = movieDataDTO.popularity ?? 0
        self.voteAverage = movieDataDTO.vote_average ?? 0
    }
    
    var popularityIndex: Int {
        //according to records 1,500 or + can be considered 5 star, then:
        Int(round(popularity*5.0/1500.0))
    }
    
    var releaseDate: Date {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-mm-dd"
        if let date = dateFormater.date(from: releaseDateStr) {
            return date
        }
        return Date.distantPast
    }
    
    var imageURL: String {
        "\(EnvironmentConfiguration.hostScheme)://\(EnvironmentConfiguration.imageURL)/t/p/w500\(posterPath)"
    }
}

