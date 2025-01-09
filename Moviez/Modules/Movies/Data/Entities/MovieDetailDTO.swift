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
    
    func toDomain() -> MovieDetail {
        MovieDetail(
            id: id,
            title: title ?? "",
            originalTitle: original_title ?? "",
            overview: overview ?? "",
            posterPath: poster_path ?? "",
            originalLanguage: original_language ?? "",
            releaseDateStr: release_date ?? "",
            popularity: popularity ?? 0,
            voteAverage: vote_average ?? 0,
            genres: genres.map { $0.toDomain() },
            spokenLanguages: spoken_languages.map { $0.toDomain() },
            status: status ?? ""
        )
    }
}
