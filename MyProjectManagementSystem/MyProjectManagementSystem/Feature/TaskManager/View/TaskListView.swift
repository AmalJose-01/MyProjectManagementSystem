import SwiftUI

struct TaskListView: View {
    
    @StateObject var viewModel: TaskViewModel = TaskViewModel(dataSource: ItemDataSource.shared)
    @State private var taskList: [TaskModel] = []
    @State private var errorMessage: String?
    
    @State private var filterStatus: String = "All"
    @State private var sortOption: String = "Due Date"
    
    @State private var showingAddTaskView = false
    
    @State private var showingDeleteAlert = false
    @State private var taskToDelete: TaskModel?
    
    @EnvironmentObject var themeManager: ThemeManager
    
    // MARK: - Filter Tasks
    var filteredTasks: [TaskModel] {
        taskList.filter { task in
            switch filterStatus {
            case "Completed":
                return task.isCompleted
            case "Pending":
                return !task.isCompleted
            default:
                return true
            }
        }
    }
    
    // MARK: - Sort Tasks
    var sortedTasks: [TaskModel] {
        let filtered = filteredTasks // Step 1: Apply filtering
        let sorted: [TaskModel]
        
        switch sortOption {
        case "Priority":
            sorted = filtered.sorted { priorityValue($0.priority) < priorityValue($1.priority) }
        case "Alphabetical":
            sorted = filtered.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        default:
            sorted = filtered.sorted { $0.dueDate < $1.dueDate }
        }
        
        return sorted
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
                
                // Task List with Swipe Actions
                List {
                    ForEach(sortedTasks) { task in
                        NavigationLink(destination: TaskDetailView(task: Binding.constant(task))) {
                            TaskRowView(task: task)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                taskToDelete = task
                                showingDeleteAlert = true
                                
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
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
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await fetchTasksData()
            }
            .background(Color(UIColor.systemBackground))
            .foregroundColor(Color.primary)
            .alert("Delete Task", isPresented: $showingDeleteAlert, presenting: taskToDelete) { task in
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    deleteTask(task)
                }
            } message: { _ in
                Text("Are you sure you want to delete this task?")
            }
        }
    }
    
    // MARK: - Update UI When Sorting/Filtering Changes
    private func updateTaskList() {
        taskList = viewModel.tasks // ✅ Correctly updates the task list
    }
    
    // MARK: - Fetch Data Asynchronously
    private func fetchTasksData() async {
        do {
            taskList = await viewModel.getTasks()
        } catch {
            errorMessage = "Failed to fetch task data: \(error.localizedDescription)"
            print(error)
        }
    }
    
    // MARK: - Delete Task
    //    private func deleteTask(_ task: TaskModel) {
    //        taskList.removeAll { $0.id == task.id }
    //        viewModel.deleteTask(task)
    //        updateTaskList()
    //    }
    
    private func deleteTask(_ task: TaskModel) {
        if viewModel.deleteTask(task) {
            taskList.removeAll { $0.id == task.id }
            updateTaskList()
        } else {
            errorMessage = "Failed to delete task."
        }
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

