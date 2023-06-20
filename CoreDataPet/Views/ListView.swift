//
//  ContentView.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 15/06/23.
//

import SwiftUI
import CoreData

struct ListView: View {
    @StateObject var listViewModel = ListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(listViewModel.pets) { pet in
                    NavigationLink(destination: InfoView(infoViewModel: InfoViewModel(pet: pet))) {
                        HStack {
                            Image(uiImage: UIImage(data: pet.image ?? Data()) ?? UIImage(systemName: "photo")!)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .cornerRadius(10)
                            
                            Spacer()
                            
                            Text(pet.name)
                                .font(.title)
                        }

                    }
                }.onDelete { IndexSet in
                    IndexSet.forEach { index in
                        let pet = listViewModel.pets[index]
                        listViewModel.deletePet(pet: pet)
                    }
                }
            }
            .navigationBarTitle("Lista de Pets")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddView()
                    } label: {
                        Text("Add")
                    }
                }
            })
            .onAppear{
                listViewModel.fetchAllPets()
            }
        }
    }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

