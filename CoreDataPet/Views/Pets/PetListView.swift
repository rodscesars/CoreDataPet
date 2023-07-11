//
//  ContentView.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 15/06/23.
//

import SwiftUI
import CoreData

struct PetListView: View {
    @StateObject var listViewModel = PetListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if listViewModel.pets.isEmpty {
                    VStack {
                        Spacer()
                        Text("Não há nenhum pet cadastrado")
                    }
                }
                List {
                    ForEach(listViewModel.pets) { pet in
                        NavigationLink {
                            PetInfoView(infoViewModel: PetInfoViewModel(pet: pet))
                        } label: {
                            HStack {
                                Image(uiImage: UIImage(data: pet.image ?? Data()) ?? UIImage(systemName: "photo")!)
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                    .clipShape(Circle())
                                
                                Spacer()
                                
                                Text(pet.name)
                            }
                            .alignmentGuide(.listRowSeparatorLeading) { d in
                                d[.leading]
                            }
                        }
                    }
                    .onDelete { IndexSet in
                        IndexSet.forEach { index in
                            let pet = listViewModel.pets[index]
                            listViewModel.deletePet(pet: pet)
                        }
                    }
                }
            }
            
            .navigationBarTitle("Pets")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        PetAddView()
                    } label: {
                        Text("Adicionar")
                    }
                }
            })
            .onAppear{
                listViewModel.fetchAllPets()
            }
        }
    }
}


struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        PetListView()
    }
}

