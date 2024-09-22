//
//  MoviePopularityView.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import SwiftUI

struct MoviePopularityView: View {
    
    var rate: Int
    
    var body: some View {
        HStack(spacing: 7) {
            ForEach(1...5, id: \.self) { r in
                Image(systemName: AppConstants.Movies.Icons.popularityIcon)
                    .foregroundColor(r <= rate ? .accentColor : .gray)
            }
        }
    }
}

#Preview {
    MoviePopularityView(rate: 3)
}
