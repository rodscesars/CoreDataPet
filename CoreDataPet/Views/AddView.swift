//
//  SendView.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 15/06/23.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var addViewModel = AddViewModel()

    @State var showImagePicker = false
    @State private var showAlert = false
       
    var body: some View {
        VStack {
            if addViewModel.selectedImage.count != 0  {
                Image(uiImage: UIImage(data: addViewModel.selectedImage) ?? UIImage()).renderingMode(.original).resizable().frame(width: 150, height: 150)
            } else {
                Image(systemName: "photo.fill").font(.system(size: 55))
            }
            
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Selecionar imagem")
            }.padding()
            
            Form {
                Section("Adicionar PET") {
                    TextField("Nome", text: $addViewModel.name)
                    
                    Picker("Gênero", selection: $addViewModel.selectedGender) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                    
                    DatePicker("Data de Nascimento", selection: $addViewModel.birthDate, displayedComponents: .date)
                    
                    Stepper(value: $addViewModel.weight, in: 0...100, step: 0.1) {
                        Text("Peso: \(addViewModel.weight, specifier: "%.1f") kg")
                    }
                    
                    Toggle("Castrado?", isOn: $addViewModel.isNeutered)
                    
                    Picker("Espécie", selection: $addViewModel.selectedSpecie) {
                        ForEach(Specie.allCases, id: \.self) { specie in
                            Text(specie.rawValue).tag(specie)
                        }
                    }
                    
                    Picker("Raça", selection: $addViewModel.selectedBreed) {
                        ForEach(addViewModel.selectedSpecie.breed, id: \.self) { breed in
                            Text(breed).tag(breed)
                        }
                    }
                }
                
                Button("Enviar") {
                    addViewModel.createPet()
                    showAlert = true
                }
            }
        }.alert("Sucesso!", isPresented: $showAlert) {
            Button("Ok") {
                self.presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Pet salvo com sucesso!")
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $addViewModel.selectedImage)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
