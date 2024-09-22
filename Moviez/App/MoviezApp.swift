//
//  MoviezApp.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import SwiftUI
import SwiftData

@main
struct MoviezApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FavoriteMovie.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MoviesDashboardView()
        }
        .modelContainer(sharedModelContainer)
    }
}
