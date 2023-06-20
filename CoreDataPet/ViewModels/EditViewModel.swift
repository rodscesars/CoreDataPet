//
//  EditViewModel.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 16/06/23.
//

import Foundation

class EditViewModel: ObservableObject {
    
    func updatePet(pet: Pet, image: Data) {
        pet.image = image
        CoreDataManager.shared.saveData()
    }
}
