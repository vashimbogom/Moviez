//
//  MovieDetailDTO.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import Foundation

struct MovieDetailDTO: Decodable, Identifiable {
    
    let id: Int
    let title: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let original_language: String?
    let release_date: String?
    let popularity: Double?
    let vote_average: Double?
    let genres: [MovieGenreDTO]
    let spoken_languages: [SpokenLanguageDTO]
    let status: String?
}
