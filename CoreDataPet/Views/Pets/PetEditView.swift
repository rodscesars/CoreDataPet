//
//  EditView.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 16/06/23.
//

import SwiftUI

struct PetEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var editViewModel: PetAddViewModel = PetAddViewModel()
    
    @Binding var pet: Pet
    
    @State private var showAlert = false
    

    var body: some View {
        NavigationView {
            VStack {
                PhotoSelector(imageData: $pet.image)
                
                Form {
                    Section("Editar PET") {
                        
                        TextField("Nome", text: $pet.name)
                        
                        Picker("Gênero", selection: $pet.gender) {
                            ForEach(Gender.allCases, id: \.self) { gender in
                                Text(gender.rawValue).tag(gender)
                            }
                        }
                        
                        DatePicker("Data de Nascimento", selection: Binding {
                            return pet.birthDate ?? .now
                        } set: { newValue  in
                            pet.birthDate = newValue
                        }, displayedComponents: .date)
                        
                        
                        Stepper(value: $pet.weight, in: 0...100, step: 0.1) {
                            Text("Peso: \(pet.weight, specifier: "%.1f") kg")
                        }
                        
                        Toggle("Castrado?", isOn: $pet.isNeutered)
                        
                        Picker("Espécie", selection: $pet.specie) {
                            ForEach(Specie.allCases, id: \.self) { specie in
                                Text(specie.rawValue).tag(specie)
                            }
                        }
                        
                        Picker("Raça", selection: $pet.breed) {
                            ForEach(pet.specie.breed, id: \.self) { breed in
                                Text(breed).tag(breed)
                            }
                        }
                    }
                }
            }
            .padding()
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        editViewModel.updatePet()
                        showAlert = true
                    }
                }
            })
            .alert("Sucesso", isPresented: $showAlert) {
                Button("Ok") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } message: {
                Text("Pet editado com com sucesso!")
            }
            .navigationTitle("Editar Pet")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct PetEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        PetEditView()
//    }
//}
