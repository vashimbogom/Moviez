//
//  MovieGenre.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import Foundation

struct MovieGenre: Decodable, Identifiable {
    let id: Int
    let name: String
    
    init(from movieGenreDTO: MovieGenreDTO) {
        self.id = movieGenreDTO.id
        self.name = movieGenreDTO.name ?? ""
    }
}
