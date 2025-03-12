//
//  MyProjectManagementSystemApp.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//

import SwiftUI
import SwiftData

@main
struct MyProjectManagementSystemApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TaskModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @StateObject private var themeManager = ThemeManager()

    

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)

        }
        .modelContainer(sharedModelContainer)
    }
}
