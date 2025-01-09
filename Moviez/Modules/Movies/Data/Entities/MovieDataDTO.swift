//
//  MovieDataDTO.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation

struct MovieDataDTO: Decodable, Identifiable {
    
    let id: Int
    let title: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let original_language: String?
    let release_date: String?
    let popularity: Double?
    let vote_average: Double?
    
    func toDomain() -> MovieData {
        MovieData(
            id: self.id,
            title: self.title ?? "",
            originalTitle: self.original_title ?? "",
            overview: self.overview ?? "",
            posterPath: self.poster_path ?? "",
            originalLanguage: self.original_language ?? "",
            releaseDateStr: self.release_date ?? "",
            popularity: self.popularity ?? 0,
            voteAverage: self.vote_average ?? 0
        )
    }
}
