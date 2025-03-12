//
//  TaskRowView.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//
import SwiftUI

 struct TaskRowView: View {
    let task: TaskModel
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(task.isCompleted ? Color.green : Color.gray)
                .frame(width: 12, height: 12)
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                if let desc = task.desc {
                    Text(desc)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                HStack {
                    Text("Priority: \(task.priority)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(task.dueDate, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 1)
    }
}
