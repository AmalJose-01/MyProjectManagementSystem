//
//  TaskRowView.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//
import SwiftUI



 struct TaskRowView: View {
    let task: TaskModel
    let onDelete: () -> Void
    let onComplete: () -> Void
    
    @State private var showUndoSnackbar = false
    @State private var recentlyDeletedTask: TaskModel?
    
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
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                recentlyDeletedTask = task
                onDelete()
                showUndoSnackbar = true
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .tint(.red)
        }
        .swipeActions(edge: .leading) {
            Button {
                onComplete()
            } label: {
                Label(task.isCompleted ? "Unmark" : "Complete", systemImage: task.isCompleted ? "arrow.uturn.backward.circle" : "checkmark.circle")
            }
            .tint(.green)
        }
        .overlay(
            Group {
                if showUndoSnackbar {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Task deleted").foregroundColor(.white)
                            Button("Undo") {
                                if let task = recentlyDeletedTask {
                                    onDelete()  // Restore the deleted task
                                    showUndoSnackbar = false
                                }
                            }
                            .foregroundColor(.yellow)
                        }
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .transition(.move(edge: .bottom))
                    }
                    .padding()
                } else {
                    EmptyView()
                }
            }
        )

    }
}




