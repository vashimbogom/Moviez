//
//  SpokenLanguage.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import Foundation

struct SpokenLanguage: Decodable, Hashable {
    let englishName: String
    let iso639_1: String
    let name: String
    
    init(from spokenLanguageDTO: SpokenLanguageDTO) {
        self.englishName = spokenLanguageDTO.english_name ?? ""
        self.iso639_1 = spokenLanguageDTO.iso_639_1 ?? ""
        self.name = spokenLanguageDTO.name ?? ""
    }
}
