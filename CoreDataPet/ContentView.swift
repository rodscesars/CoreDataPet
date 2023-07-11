//
//  ContentView.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 03/07/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PetListView().tabItem {
                Label("Pets", systemImage: "pawprint.circle.fill")
            }
            TaskListView().tabItem {
                Label("Tarefas", systemImage: "list.bullet.clipboard.fill")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
