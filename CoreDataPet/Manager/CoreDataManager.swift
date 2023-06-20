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
        
    let request: NSFetchRequest<Pet> = Pet.fetchRequest()
    
    func fetchAll() -> [Pet] {
        var pets = [Pet]()
        do {
            let fetchedPets = try self.container.viewContext.fetch(request)
            pets = fetchedPets
        } catch let error as NSError {
            print("\(error): Ocorreu um erro na busca de Pets")
        }
        return pets
    }
    
//    func fetchById(id: UUID) -> Pet? {
//        var pets = [Pet]()
//        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
//        do {
//            pets = try self.container.viewContext.fetch(request)
//        } catch let error as NSError {
//            print("\(error): O pet não foi encontrado!")
//        }
//        return pets.first
//    }
    
    func create(name: String, image: Data, gender: Gender, specie: Specie, breed: String, birthDate: Date, weight: Double, isNeutered: Bool) {
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
    
    func saveData() {
        do {
            try self.container.viewContext.save()
        } catch let error as NSError {
            print("\(error): Não foi possível editar o Pet")
        }
    }
    
    func delete(pet: Pet) {
            self.container.viewContext.delete(pet)
            saveData()
    }
}
