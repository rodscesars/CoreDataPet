//
//  ListViewModel.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 16/06/23.
//

import Foundation

class PetListViewModel: ObservableObject {
    
    @Published var pets = [Pet]()
        
    func fetchAllPets() {
        pets = CoreDataManager.shared.fetchAllPets()
    }
    
    func deletePet(pet: Pet) {
        CoreDataManager.shared.deletePet(pet: pet)
        fetchAllPets()
    }
}
