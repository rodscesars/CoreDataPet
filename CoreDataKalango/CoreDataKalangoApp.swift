//
//  CoreDataKalangoApp.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 15/06/23.
//

import SwiftUI

@main
struct CoreDataKalangoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
