//
//  TaskViewModel.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//

import Foundation

import SwiftUI
import SwiftData





class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    @Published var filterStatus: TaskStatus? = nil
    @Published var sortOption: SortOption = .priority

      private let dataSource: ItemDataSourceProtocol

   
    
    init(dataSource: ItemDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    @MainActor
    func getTasks() async -> [TaskModel] {
        self.tasks = self.dataSource.fetchItems() // No need for DispatchQueue.main.async inside @MainActor
        return self.tasks
    }
    
    
//    func deleteTask(_ task: TaskModel) {
//           dataSource.deleteTask(task)
//       }
    
    func deleteTask(_ task: TaskModel) -> Bool {
           let success = dataSource.deleteTask(task)
           
           if success {
               return success
           } else {
               print("Failed to delete task.")
               return success
           }
       }
    
    
   
}

enum SortOption {
    case priority, dueDate, alphabetical
}

enum TaskStatus: String, CaseIterable {
    case all = "All"
    case completed = "Completed"
    case pending = "Pending"
}
