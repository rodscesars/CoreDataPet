//
//  TaskDetailViewModel.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 04/07/23.
//

import Foundation

class TaskDetailViewModel: ObservableObject {
    
    @Published var task: PetTask
    
    init(task: PetTask) {
        self.task = task
    }
}
