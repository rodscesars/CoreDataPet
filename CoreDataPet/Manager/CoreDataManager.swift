//
//  CoreDataManager.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 15/06/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDataPet")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
        
    let petRequest: NSFetchRequest<Pet> = Pet.fetchRequest()
    let taskRequest: NSFetchRequest<PetTask> = PetTask.fetchRequest()
    
    func saveData() {
        do {
            try self.container.viewContext.save()
        } catch let error as NSError {
            print("\(error): Não foi possível editar o Pet")
        }
    }
    
    //PETS
    
    func fetchAllPets() -> [Pet] {
        var pets = [Pet]()
        do {
            let fetchedPets = try self.container.viewContext.fetch(petRequest)
            pets = fetchedPets
        } catch let error as NSError {
            print("\(error): Ocorreu um erro na busca de Pets")
        }
        return pets
    }
        
    func createPet(name: String, image: Data, gender: Gender, specie: Specie, breed: String, birthDate: Date, weight: Double, isNeutered: Bool) {
        let newPet = Pet(context: self.container.viewContext)
        newPet.id = UUID()
        newPet.name = name
        newPet.image = image
        newPet.gender = gender
        newPet.specie = specie
        newPet.breed = breed
        newPet.birthDate = birthDate
        newPet.weight = weight
        newPet.isNeutered = isNeutered
        saveData()
    }
    
    func deletePet(pet: Pet) {
            self.container.viewContext.delete(pet)
            saveData()
    }
    
    //TASKS
    
    func fetchAllTasks() -> [PetTask] {
        var tasks = [PetTask]()
        do {
            let fetchedTasks = try self.container.viewContext.fetch(taskRequest)
            tasks = fetchedTasks
        } catch let error as NSError {
            print("\(error): Ocorreu um erro na busca de Taredas")
        }
        return tasks
    }
    
    func createTask(title: String, type: TaskType, pet: Pet, replay: Replay, reminder: Reminder, date: Date, time: Date, summary: String) {
        let newTask = PetTask(context: self.container.viewContext)
        newTask.id = UUID()
        newTask.title = title
        newTask.type = type
        newTask.replay = replay
        newTask.reminder = reminder
        newTask.date = date
        newTask.time = time
        newTask.summary = summary
        newTask.pet = pet
        saveData()
    }
    
    func deleteTask(task: PetTask) {
            self.container.viewContext.delete(task)
            saveData()
    }
}
