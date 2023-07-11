//
//  TaskType.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 03/07/23.
//

import Foundation

enum TaskType: String, CaseIterable, Identifiable, Hashable {
    var id: Self { self }
    
    case none = "Nenhum"
    case vaccine = "Vacina"
    case medicine = "Remédio"
    case leisure = "Lazer"
    case hygiene = "Higiene"
    case others = "Outros"
}
