//
//  MovieGenreDTO.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

struct MovieGenreDTO: Decodable {
    let id: Int
    let name: String?
    
    func toDomain() -> MovieGenre {
        MovieGenre(id: id, name: name ?? "")
    }
}
