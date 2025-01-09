//
//  MovieDataHelper.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 08/01/25.
//
import Foundation

protocol MovieDataHelper {
    func getPopularityIndex(popularity: Double) -> Int
    func getReleaseDate(dateStr: String) -> Date
    func getImageURL(posterPath: String) -> String
}

extension MovieDataHelper {
    
    func getPopularityIndex(popularity: Double) -> Int {
        Int(round(popularity*5.0/1500.0))
    }
    
    func getReleaseDate(dateStr: String) -> Date {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-mm-dd"
        if let date = dateFormater.date(from: dateStr) {
            return date
        }
        return Date.distantPast
    }
    
    func getImageURL(posterPath: String) -> String {
        "\(EnvironmentConfiguration.hostScheme)://\(EnvironmentConfiguration.imageURL)/t/p/w500\(posterPath)"
    }
}
