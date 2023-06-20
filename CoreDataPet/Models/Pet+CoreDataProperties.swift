//
//  Pet+CoreDataProperties.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 16/06/23.
//
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var genderValue: String?
    @NSManaged public var image: Data?
    @NSManaged public var specieValue: String?
    @NSManaged public var breedValue: String?
    @NSManaged public var birthDate: Date?
    @NSManaged public var weight: Double
    @NSManaged public var isNeutered: Bool
    
    var breed: String {
        get {
            return breedValue ?? ""
        }
        set {
            breedValue = newValue
        }
    }
    
    var gender: Gender {
        get {
            return Gender(rawValue: genderValue!) ?? .none
        }
        set {
            genderValue = newValue.rawValue
        }
    }
    
    var specie: Specie {
        get {
            return Specie(rawValue: specieValue!) ?? .none
        }
        set {
            specieValue = newValue.rawValue
        }
    }

}

extension Pet : Identifiable {

}
