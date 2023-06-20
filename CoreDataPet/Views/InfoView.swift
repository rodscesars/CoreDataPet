//
//  InfoView.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 16/06/23.
//

import SwiftUI

struct InfoView: View {
    
    @StateObject var infoViewModel: InfoViewModel
    
    @State var showEdit:Bool = false
    
    var body: some View {
        VStack {
            if(infoViewModel.pet.image?.count != 0) {
                Image(uiImage: UIImage(data: infoViewModel.pet.image ?? Data()) ?? UIImage())
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()
            }
            
            
            HStack {
                Text("ID")
                Spacer()
                Text(infoViewModel.pet.id.uuidString)
                    .font(.footnote)
            }
            
            HStack {
                Text("Nome")
                Spacer()
                Text(infoViewModel.pet.name)
            }
            
            HStack {
                Text("Gênero")
                Spacer()
                Text(infoViewModel.pet.gender.rawValue)
            }
            
            HStack {
                Text("Espécie")
                Spacer()
                Text(infoViewModel.pet.specie.rawValue)
                
            }
            
            HStack {
                Text("Raça")
                Spacer()
                Text(infoViewModel.pet.breed == "" ? "Não Escolhido" : infoViewModel.pet.breed)
            }
            
            HStack {
                Text("Data de Nascimento")
                Spacer()
                Text(infoViewModel.formattedBirthDate(date: infoViewModel.pet.birthDate ?? .now))
            }
            
            HStack {
                Text("Peso")
                Spacer()
                Text("\(String(format: "%.1f", infoViewModel.pet.weight)) kg")
            }
            
            HStack {
                Text("É castrado?")
                Spacer()
                Text(infoViewModel.pet.isNeutered ? "Sim" : "Não")
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showEdit.toggle()
                } label: {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $showEdit) {
            EditView(pet: $infoViewModel.pet, selectedImage: infoViewModel.pet.image ?? Data())
        }
    }
}

//struct InfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoView()
//    }
//}
