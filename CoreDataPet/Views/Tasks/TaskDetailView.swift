//
//  TaskDetailView.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 03/07/23.
//

import SwiftUI

struct TaskDetailView: View {
    
    @StateObject var detailViewModel: TaskDetailViewModel
    @State var showEdit: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: UIImage(data: detailViewModel.task.pet?.image ?? Data()) ?? UIImage(systemName: "pawprint.circle.fill")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 194)
                .clipped()
            
            VStack(alignment: .leading, spacing: 24.0) {
                Text(detailViewModel.task.title)
                    .font(.system(size: 28, weight: .semibold))
                
                VStack(alignment: .leading, spacing: 16.0) {
                    HStack(spacing: 8.0) {
                        Image(systemName: "pawprint.fill")
                        Text(detailViewModel.task.pet?.name ?? "Não Informado")
                    }
                    HStack(spacing: 8.0) {
                        Image(systemName: "calendar")
                        Text(Helper.shared.formattedBirthDate(date: detailViewModel.task.date ?? .now))
                    }
                    HStack(spacing: 8.0) {
                        Image(systemName: "clock.fill")
                        Text(Helper.shared.timeFormatter(time: detailViewModel.task.time ?? .now))
                    }
                    HStack(spacing: 8.0) {
                        Image(systemName: "bell.fill")
                        Text(detailViewModel.task.reminder.rawValue)
                    }
                }
                
                Text(detailViewModel.task.summary)
            }.padding()
            
            HStack {
                Spacer()
                Button("Marcar como concluída") {
                    detailViewModel.task.isDone.toggle()
                }
                .font(.system(size: 16, weight: .semibold))
                .padding(.vertical, 15.0)
                .padding(.horizontal, 40.0)
                .foregroundColor(.white)
                .background(Color(red: 0.24, green: 0.2, blue: 0.81))
                .cornerRadius(8)
                Spacer()
            }
            
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
        .navigationTitle(detailViewModel.task.type.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showEdit) {
            EditTaskView(task: $detailViewModel.task)
        }
    }
}

//struct TaskDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskDetailView()
//    }
//}
