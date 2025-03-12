//
//  TaskViewModelTest.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//



import XCTest
@testable import MyProjectManagementSystem

final class TaskViewModelTests: XCTestCase {
    var viewModel: TaskViewModel!
    var mockDataSource: MockItemDataSource!

    override func setUp() {
        super.setUp()
        let sampleTasks = [
            TaskModel(title: "Task 1", priority: "High", dueDate: Date()),
            TaskModel(title: "Task 2", priority: "Medium", dueDate: Date().addingTimeInterval(86400)),
            TaskModel(title: "Task 3", priority: "Low", dueDate: Date().addingTimeInterval(172800))
        ]
        mockDataSource = MockItemDataSource(mockTasks: sampleTasks)
        viewModel = TaskViewModel(dataSource: mockDataSource)
    }

    override func tearDown() {
        viewModel = nil
        mockDataSource = nil
        super.tearDown()
    }

    // Your test methods
}



final class MockItemDataSource: ItemDataSourceProtocol {
    private var mockTasks: [TaskModel]

    init(mockTasks: [TaskModel] = []) {
        self.mockTasks = mockTasks
    }

    func saveMemberDetail(memberDetail: TaskModel) -> Bool {
        mockTasks.append(memberDetail)
        return true
    }

    func fetchItems() -> [TaskModel] {
        return mockTasks
    }

    func deleteTask(_ task: TaskModel) {
        mockTasks.removeAll { $0.id == task.id }
    }
}

