//
//  MovieDataList.swift
//  Moviez
//
//

struct MoviesDataList: Decodable {
    
    let page: Int
    let movies: [MovieData]
    let totalPages: Int
    let totalResults: Int
}
