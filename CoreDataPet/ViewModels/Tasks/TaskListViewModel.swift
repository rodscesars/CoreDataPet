//
//  TaskListViewModel.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 03/07/23.
//

import Foundation

class TaskListViewModel: ObservableObject {
    
    @Published var tasks = [PetTask]()
    
    func fetchAllTasks() {
        tasks = CoreDataManager.shared.fetchAllTasks()
    }
    
    func deleteTask(task: PetTask) {
        CoreDataManager.shared.deleteTask(task: task)
        fetchAllTasks()
    }
}
