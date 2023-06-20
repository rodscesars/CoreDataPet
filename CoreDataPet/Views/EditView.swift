//
//  EditView.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 16/06/23.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var editViewModel: EditViewModel = EditViewModel()
    
    @Binding var pet: Pet
    
    @State var showImagePicker = false
    @State private var showAlert = false
    
    @State var selectedImage: Data
    
    var body: some View {
        VStack {
            if selectedImage.count != 0  {
                Image(uiImage: UIImage(data: selectedImage) ?? UIImage())
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 150, height: 150)
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
                
                Button("Editar") {
                    editViewModel.updatePet(pet: pet, image: selectedImage)
                    showAlert = true
                }
            }
        }
        .padding()
        .alert("Sucesso", isPresented: $showAlert) {
            Button("Ok") {
                self.presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Pet editado com com sucesso!")
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .onDisappear{
            pet.image = selectedImage
        }
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView()
//    }
//}
