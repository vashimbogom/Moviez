//
//  MovieErrorView.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import SwiftUI

struct MovieErrorView: View {
    
    let errorTitle: String
    let errorDescription: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: AppConstants.Movies.Icons.errorViewIcon)
                .font(.system(size: 44))
                .foregroundColor(.orange)
                .padding(5)
            Text(errorTitle)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding(5)
            Text(errorDescription)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(5)
            Button {
                retryAction()
            } label: {
                Text(
                    LocalizedStringResource(
                        String.LocalizationValue(AppConstants.MovieStrings.Errors.tryAgain),
                        table: AppConstants.Movies.localizationTable))
                .bold()
            }
        }
        .padding(50)
        .animation(.easeInOut, value: 0.5)
        .preferredColorScheme(.light)
    }
}
