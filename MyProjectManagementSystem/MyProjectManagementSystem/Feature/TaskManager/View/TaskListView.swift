//
//  TaskListView.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//

import SwiftUI

struct TaskListView: View {
    
    @StateObject var viewModel: TaskViewModel = TaskViewModel(dataSource: .shared)
    @State private var taskList: [TaskModel] = []
    @State private var errorMessage: String?
    
    @State private var filterStatus: String = "All"
    @State private var sortOption: String = "Due Date"
    
    @State private var showingAddTaskView = false
    
    @EnvironmentObject var themeManager: ThemeManager
    
    var filteredTasks: [TaskModel] {
        taskList.filter { task in
            filterStatus == "All" || (filterStatus == "Completed" && task.isCompleted) || (filterStatus == "Pending" && !task.isCompleted)
        }
    }
    
    var sortedTasks: [TaskModel] {
        filteredTasks.sorted {
            switch sortOption {
            case "Priority":
                return priorityValue($0.priority) < priorityValue($1.priority)
            case "Alphabetical":
                return $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
            default:
                return $0.dueDate < $1.dueDate
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // Status Filter
                Picker("Status", selection: $filterStatus) {
                    Text("All").tag("All")
                    Text("Completed").tag("Completed")
                    Text("Pending").tag("Pending")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .onChange(of: filterStatus) { _ in updateTaskList() }
                
                // Sorting Options
                HStack {
                    Text("Sort by:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Picker("Sort By", selection: $sortOption) {
                        Text("Due Date").tag("Due Date")
                        Text("Priority").tag("Priority")
                        Text("Alphabetical").tag("Alphabetical")
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal)
                .onChange(of: sortOption) { _ in updateTaskList() }
                
                // Scrollable LazyVStack for better performance
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(sortedTasks, id: \.id) { task in
                            NavigationLink(destination: TaskDetailView(task: Binding.constant(task), onDelete: {
                                deleteTask(task)
                            })) {
                                TaskRowView(task: task)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                .refreshable {
                    await fetchTasksData()
                }
                
                // Add Task Button
                Button(action: {
                    showingAddTaskView = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                        
                        Text("Add Task")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(colors: [Color.blue, Color.purple], startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                }
                .padding()
                .sheet(isPresented: $showingAddTaskView) {
                    AddTaskView()
                }
            }
            .navigationTitle("Task Manager")
            .onAppear {
                Task {
                    await fetchTasksData()
                }
            }
            .background(Color(UIColor.systemBackground)) // Supports dark & light mode
            .foregroundColor(Color.primary) // Adjust text color for contrast
        }
    }
    
    // MARK: - Task Row View (for cleaner structure)
    private struct TaskRowView: View {
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
    
    // MARK: - Update UI When Sorting/Filtering Changes
    private func updateTaskList() {
        taskList = taskList // ✅ Triggers SwiftUI to refresh the view
    }
    
    // MARK: - Fetch Data Asynchronously
    private func fetchTasksData() async {
        do {
            taskList = await viewModel.getPlayers()
        } catch {
            errorMessage = "Failed to fetch task data: \(error.localizedDescription)"
            print(error)
        }
    }
    
    // MARK: - Delete Task
    private func deleteTask(_ task: TaskModel) {
        taskList.removeAll { $0.id == task.id }
        viewModel.deleteTask(task)
        updateTaskList()
    }
    
    // MARK: - Priority Value Converter
    private func priorityValue(_ priority: String) -> Int {
        switch priority {
        case "High":
            return 1
        case "Medium":
            return 2
        case "Low":
            return 3
        default:
            return 4
        }
    }
}

