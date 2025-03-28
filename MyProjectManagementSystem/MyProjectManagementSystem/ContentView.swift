//
//  ContentView.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

   
    var body: some View {
        VStack {
            TabView {
                TaskListView()
                    .tabItem {
                        Label("Task", image: "TaskIcon")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("Settings", image: "SettingsIcon")
                    }
                
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
