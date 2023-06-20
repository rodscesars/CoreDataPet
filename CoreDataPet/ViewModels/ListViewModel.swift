//
//  ListViewModel.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 16/06/23.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var pets = [Pet]()
        
    func fetchAllPets() {
        pets = CoreDataManager.shared.fetchAll()
    }
    
    func deletePet(pet: Pet) {
        CoreDataManager.shared.delete(pet: pet)
        fetchAllPets()
    }
}
