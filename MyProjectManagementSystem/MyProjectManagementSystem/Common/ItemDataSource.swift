//
//  ItemDataSource.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//

import SwiftData
import _SwiftData_SwiftUI
import Foundation

final class ItemDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = ItemDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: TaskModel.self)
        self.modelContext = modelContainer.mainContext
    }
    
    func saveMemberDetail(memberDetail: TaskModel) -> Bool {
        modelContext.insert(memberDetail)
        do {
            try modelContext.save()
            print("Task saved successfully!")
            return true
        } catch {
            print("Failed to save task: \(error.localizedDescription)")
            return false
        }
    }

    func fetchItems() -> [TaskModel] {
        do {
            let tasks = try modelContext.fetch(FetchDescriptor<TaskModel>())
            print("Fetched tasks: \(tasks)")
            return tasks
        } catch {
            print("Failed to fetch tasks: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteTask(_ task: TaskModel) {
           // Implement SwiftData deletion logic here
       }
    

    
}
