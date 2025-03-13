//
//  AddTaskViewModel.swift
//  MyProjectManagementSystem
//
//  Created by Amal Jose on 12/3/2025.
//

import Foundation

final class AddTaskViewModel: ObservableObject{
    private let dataSource: ItemDataSource
    init(dataSource: ItemDataSource) {
        self.dataSource = dataSource
    }

   
    
    func saveMemberDetail(taskDetail: TaskModel) -> Bool {
        let response = dataSource.saveMemberDetail(memberDetail: taskDetail)
        if response {
            Task { await TaskViewModel(dataSource: dataSource).getTasks() } // Refresh task list
        }
        return response
    }
    
}

