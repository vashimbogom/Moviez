//
//  SpokenLanguageDTO.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//


struct SpokenLanguageDTO: Decodable {
    let english_name: String?
    let iso_639_1: String?
    let name: String?
    
    func toDomain() -> SpokenLanguage {
        SpokenLanguage(englishName: english_name ?? "", iso639_1: iso_639_1 ?? "", name: name ?? "")
    }
}
