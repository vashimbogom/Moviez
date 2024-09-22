//
//  MoviesDashboardView.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import SwiftUI

struct MoviesDashboardView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    MoviesText("Trending movies...")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    //Trending Movies List
                    
                    MoviesText("Now playing")
                        .font(.title)
                        .fontWeight(.bold)
                    //Now Playing Grid
                    

                }
                .padding(.vertical)
                
            }
            .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview("EN") {
    MoviesDashboardView()
}

#Preview("ES") {
    MoviesDashboardView()
        .environment(\.locale, Locale(identifier: "es-419"))
}
