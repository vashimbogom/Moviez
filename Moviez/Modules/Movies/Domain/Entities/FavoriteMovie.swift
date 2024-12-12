//
//  FavoriteMovie.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import Foundation
import SwiftData

@Model
final class FavoriteMovie {
    var movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
}
