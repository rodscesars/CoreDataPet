//
//  AddViewModel.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 16/06/23.
//

import Foundation

class PetAddViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var birthDate: Date = .now
    @Published var isNeutered: Bool = false
    @Published var weight: Double = 0
    @Published var selectedBreed: String = ""
    @Published var selectedSpecie: Specie = .none
    @Published var selectedGender: Gender = .none
    @Published var selectedImage: Data? = .init(count: 0)
    
    func createPet() {
        CoreDataManager.shared.createPet(name: name, image: selectedImage ?? Data(), gender: selectedGender, specie: selectedSpecie, breed: selectedBreed, birthDate: birthDate, weight: weight, isNeutered: isNeutered)
        _ = CoreDataManager.shared.fetchAllPets()
    }
    
    func updatePet() {
        CoreDataManager.shared.saveData()
        _ = CoreDataManager.shared.fetchAllPets()
    }
}
