//
//  EditTask.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 04/07/23.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var editViewModel = AddTaskViewModel()
    @Binding var task: PetTask
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Título", text: $task.title)
                        
                        Picker("Tipo de tarefa", selection: $task.type) {
                            ForEach(TaskType.allCases, id: \.self) { task in
                                Text(task.rawValue)
                            }
                        }
                        
                        Picker("Pet", selection: $task.pet) {
                            ForEach(editViewModel.pets, id: \.id) { pet in
                                Text(pet.name).tag(pet as Pet?)
                            }
                        }
                    }
                    Section {
                        DateTimeInput(selectedDate: $task.date, selectedTime: $task.time)
                        
                        Picker("Repetir", selection: $task.replay) {
                            ForEach(Replay.allCases, id: \.self) { replay in
                                Text(replay.rawValue)
                            }
                        }
                        Picker("Lembrete", selection: $task.reminder) {
                            ForEach(Reminder.allCases, id: \.self) { reminder in
                                Text(reminder.rawValue)
                            }
                        }
                        
                    }
                    Section {
                        TextField("Descrição", text: $task.summary)
                            .frame(width: 327, height: 200, alignment: .topLeading)
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        editViewModel.updateTask()
                        showAlert = true
                    }
                }
            })
            .navigationTitle("Editar Task")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Sucesso!", isPresented: $showAlert) {
                Button("Ok") {
                    dismiss()
                }
            } message: {
                Text("Task editada com sucesso!")
            }
            .onAppear{
                editViewModel.fetchAllPets()
            }
        }
    }
}

//struct EditTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTaskView()
//    }
//}
