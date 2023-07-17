//
//  AddTaskViewModel.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 03/07/23.
//

import Foundation

class AddTaskViewModel: ObservableObject {
    
    @Published var pets = [Pet]()
    
    @Published var summary: String = ""
    @Published var title: String = ""
    @Published var type: TaskType = .none
    @Published var replay: Replay = .never
    @Published var reminder: Reminder = .none
    @Published var selectedDate: Date? = Date()
    @Published var selectedTime: Date? = Date()
    @Published var isDone: Bool = false
    @Published var selectedPet: Pet?
    
    init() {
        fetchAllPets()
    }
    
    func fetchAllPets() {
        pets = CoreDataManager.shared.fetchAllPets()
    }
    
    func createTask() {
        CoreDataManager.shared.createTask(title: title, type: type, pet: selectedPet ?? Pet(context: CoreDataManager.shared.container.viewContext), replay: replay, reminder: reminder, date: selectedDate ?? .now, time: selectedTime ?? .now, summary: summary, isDone: isDone)
        _ = CoreDataManager.shared.fetchAllTasks()
    }
    
    func updateTask() {
        CoreDataManager.shared.saveData()
        _ = CoreDataManager.shared.fetchAllTasks()
    }
    
    func deleteTask(task: PetTask) {
        CoreDataManager.shared.deleteTask(task: task)
        _ = CoreDataManager.shared.fetchAllTasks()
    }
}
