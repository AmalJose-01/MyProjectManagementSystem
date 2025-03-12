//
//  AddTaskView.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//

import SwiftUI
import SwiftData

struct AddTaskView: View {
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var priority: String = "Medium"
    @State private var dueDate: Date = Date()
    
    @StateObject var addTaskViewModel: AddTaskViewModel = AddTaskViewModel(dataSource: .shared)

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Task Details Card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Task Details")
                        .font(.headline)
                        .padding(.bottom, 5)

                    TextField("Enter title", text: $title)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    TextField("Enter description", text: $description)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    // Priority Picker
                    VStack(alignment: .leading) {
                        Text("Priority").font(.subheadline).bold()
                        Picker("Priority", selection: $priority) {
                            Text("Low").tag("Low")
                            Text("Medium").tag("Medium")
                            Text("High").tag("High")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    // Due Date Picker
                    VStack(alignment: .leading) {
                        Text("Due Date").font(.subheadline).bold()
                        DatePicker("", selection: $dueDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .labelsHidden()
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)

                // Save Button
                Button(action: {
                    saveTask()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.white)
                        Text("Save Task")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(title.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(12)
                }
                .disabled(title.isEmpty)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
            .navigationTitle("Add Task")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }

    private func saveTask() {
        let taskDetail = TaskModel(title: title, desc: description, priority: priority, dueDate: dueDate, isCompleted: false)
        addTaskViewModel.saveMemberDetail(taskDetail: taskDetail)
        
        // Haptic Feedback
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        dismiss()
    }
}
