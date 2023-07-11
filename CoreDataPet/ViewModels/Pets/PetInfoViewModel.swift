//
//  InfoViewModel.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 16/06/23.
//

import Foundation

class PetInfoViewModel: ObservableObject {
    
    @Published var pet: Pet
    
    init(pet: Pet) {
        self.pet = pet
    }
}
