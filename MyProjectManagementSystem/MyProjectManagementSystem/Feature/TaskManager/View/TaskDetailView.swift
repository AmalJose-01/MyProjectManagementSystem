//
//  TaskDetailView.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//

import SwiftUI

struct TaskDetailView: View {
    @Binding var task: TaskModel // Binding to modify the task
    var onDelete: () -> Void // Callback to delete task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(task.title)
                .font(.largeTitle)
                .bold()
            
            Text(task.desc ?? "No Description")
                .font(.body)
            
            Text("Priority: \(task.priority)")
                .font(.caption)
            
            Text("Due: \(task.dueDate, style: .date)")
                .font(.caption)
            
            Toggle("Completed", isOn: $task.isCompleted)
                .padding()
            
            Spacer()
            
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Delete Task", systemImage: "trash")
                    .foregroundColor(.red)
            }
            .padding()
        }
        .padding()
        .navigationTitle("Task Details")
    }
}

