//
//  Reminder.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 03/07/23.
//

import Foundation

enum Reminder: String, CaseIterable, Identifiable, Hashable {
    var id: Self { self }
    
    case none = "Nenhum"
    case onTime = "Na hora da tarefa"
    case five = "5 minutos antes"
    case ten = "10 minutos antes"
    case fifteen = "15 minutos antes"
    case thirty = "30 minutos antes"
    case oneHour = "1 hora antes"
    case twoHour = "2 horas antes"
    case oneDay = "1 dia antes"

}
