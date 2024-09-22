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
}
