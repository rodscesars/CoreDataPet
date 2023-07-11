//
//  AddTaskView.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 03/07/23.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var addViewModel =  AddTaskViewModel()
    @State private var showAlert = false
    
    var isSaveButtonEnabled: Bool {
        return addViewModel.selectedPet != nil
    }
    
    var body: some View {
            VStack {
                Form {
                    Section {
                        TextField("Título", text: $addViewModel.title)
                        
                        Picker("Tipo de tarefa", selection: $addViewModel.type) {
                            ForEach(TaskType.allCases, id: \.self) { task in
                                Text(task.rawValue)
                            }
                        }
                        
                        Picker("Pet", selection: $addViewModel.selectedPet) {
                            Text("Nao escolhido")
                            
                            ForEach(addViewModel.pets, id: \.id) { pet in
                                Text(pet.name).tag(pet as Pet?)
                            }
                        }
                    }
                    Section {
                        DateTimeInput(selectedDate: $addViewModel.selectedDate, selectedTime: $addViewModel.selectedTime)
                        
                        Picker("Repetir", selection: $addViewModel.replay) {
                            ForEach(Replay.allCases, id: \.self) { replay in
                                Text(replay.rawValue)
                            }
                        }
                        Picker("Lembrete", selection: $addViewModel.reminder) {
                            ForEach(Reminder.allCases, id: \.self) { reminder in
                                Text(reminder.rawValue)
                            }
                        }
                        
                    }
                    Section {
                        TextField("Descrição", text: $addViewModel.summary)
                            .frame(width: 327, height: 200, alignment: .topLeading)
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Adicionar") {
                        addViewModel.createTask()
                        showAlert = true
                    }.disabled(!isSaveButtonEnabled)
                }
            })
            .navigationTitle("Adicionar Task")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Sucesso!", isPresented: $showAlert) {
                Button("Ok") {
                    dismiss()
                }
            } message: {
                Text("Task criada com sucesso!")
            }
            .onAppear{
                addViewModel.fetchAllPets()
            }
        }
}

//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskView()
//    }
//}
