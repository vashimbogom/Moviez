//
//  MoviesDataListDTO.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

struct MoviesDataListDTO: Decodable {
    
    let page: Int
    let results: [MovieDataDTO]
    let total_pages: Int
    let total_results: Int
    
    func toDomain() -> MoviesDataList {
        MoviesDataList(page: page, movies: results.map{$0.toDomain()}, totalPages: total_pages, totalResults: total_results)
    }
}
