//
//  InfoView.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 16/06/23.
//

import SwiftUI

struct PetInfoView: View {
    
    @StateObject var infoViewModel: PetInfoViewModel
    
    @State var showEdit: Bool = false
    
    var body: some View {
        VStack {
            if let image = infoViewModel.pet.image, image.count != 0 {
                Image(uiImage: UIImage(data: image) ?? UIImage())
                    .renderingMode(.original)
                    .resizable()
                    .frame(height: 194)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            } else {
                Image(systemName: "photo.fill")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 194, height: 194)
            }
            
            VStack(spacing: 8) {
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
                    Text(Helper.shared.formattedBirthDate(date: infoViewModel.pet.birthDate ?? .now))
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
            }.padding()
            
            Spacer()
        
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showEdit.toggle()
                } label: {
                    Text("Editar")
                }
            }
        }
        .sheet(isPresented: $showEdit) {
            PetEditView(pet: $infoViewModel.pet)
        }
        .navigationTitle("Informações do Pet")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct PetInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PetInfoView()
//    }
//}
