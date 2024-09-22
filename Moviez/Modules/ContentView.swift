//
//  ContentView.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        Text(LocalizedStringResource("Trending Movies", table: "LocalizableMovies"))
    }
}

#Preview("EN") {
    ContentView()
}

#Preview("ES") {
    ContentView()
        .environment(\.locale, Locale(identifier: "es-419"))
}
