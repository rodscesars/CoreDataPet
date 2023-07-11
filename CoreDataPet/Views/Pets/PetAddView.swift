//
//  SendView.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 15/06/23.
//

import SwiftUI

struct PetAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var addViewModel = PetAddViewModel()

    @State private var showAlert = false
    
    var isSaveButtonEnabled: Bool {
        return addViewModel.name != ""
    }
       
    var body: some View {
        VStack {
            PhotoSelector(imageData: $addViewModel.selectedImage)
                
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
                
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Adicionar") {
                    addViewModel.createPet()
                    showAlert = true
                }
                .disabled(!isSaveButtonEnabled)
            }
        })
        .alert("Sucesso!", isPresented: $showAlert) {
            Button("Ok") {
                self.presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Pet salvo com sucesso!")
        }
        .navigationTitle("Adicionar Pet")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PetAddView_Previews: PreviewProvider {
    static var previews: some View {
        PetAddView()
    }
}
