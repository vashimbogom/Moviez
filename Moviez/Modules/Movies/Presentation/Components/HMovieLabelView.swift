//
//  HMovieLabelView.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import SwiftUI

struct HMovieLabelView: View {
    
    var title: String
    var description: String
    
    var body: some View {
        HStack {
            Text(
                LocalizedStringResource(
                    String.LocalizationValue(title),
                    table: AppConstants.Movies.localizationTable)
            )
                .font(.footnote)
                .foregroundColor(.gray)
            Text(description)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    HMovieLabelView(title: AppConstants.Movies.Strings.title, description: AppConstants.Movies.Strings.title)
}
