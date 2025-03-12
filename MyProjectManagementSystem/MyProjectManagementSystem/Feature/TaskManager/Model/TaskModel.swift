//
//  TaskModel.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//



import SwiftData
import Foundation


@Model
class TaskModel: Identifiable {
    var id = UUID()
    var title: String
    var desc: String?
    var priority: String
    var dueDate: Date
    var isCompleted: Bool
    
    init(title: String = "", desc: String = "", priority: String = "", dueDate: Date, isCompleted: Bool = false) {
        self.title = title
        self.desc = desc
        self.priority = priority
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}


