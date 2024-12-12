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
    
    init(from movieDetailDTO: MovieDetailDTO) {
        self.id = movieDetailDTO.id
        self.title = movieDetailDTO.title ?? ""
        self.originalTitle = movieDetailDTO.original_title ?? ""
        self.overview = movieDetailDTO.overview ?? ""
        self.posterPath = movieDetailDTO.poster_path ?? ""
        self.originalLanguage = movieDetailDTO.original_language?.uppercased() ?? ""
        self.releaseDateStr = movieDetailDTO.release_date ?? ""
        self.popularity = movieDetailDTO.popularity ?? 0
        self.voteAverage = movieDetailDTO.vote_average ?? 0
        
        self.genres = movieDetailDTO.genres.map { .init(from: $0) }
        self.spokenLanguages = movieDetailDTO.spoken_languages.map { .init(from: $0) }
        self.status = movieDetailDTO.status ?? ""
    }
    
    init() {
        self.id = 0
        self.title = ""
        self.originalTitle = ""
        self.overview = ""
        self.posterPath = ""
        self.originalLanguage = ""
        self.releaseDateStr = ""
        self.popularity = 0
        self.voteAverage = 0
        
        self.genres = []
        self.spokenLanguages = []
        self.status = ""
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
