//
//  MoviesText.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import SwiftUI

struct MoviesText: View {
    
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(LocalizedStringResource(String.LocalizationValue(text), table: AppConstants.moviesLocalizationTable))
    }
}

#Preview {
    MoviesText("Trending movies...")
}
