//
//  TaskList.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 03/07/23.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var taskListViewModel = TaskListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if taskListViewModel.tasks.isEmpty {
                    VStack {
                        Spacer()
                        Text("Não há nenhuma tarefa cadastrada")
                    }
                }
                List {
                    ForEach(taskListViewModel.tasks) { task in
                        NavigationLink {
                            TaskDetailView(detailViewModel: TaskDetailViewModel(task: task))
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(task.title).font(.system(size: 16, weight: .semibold))
                                    Text(task.type.rawValue).font(.system(size: 13))
                                    HStack {
                                        Image(systemName: "clock.fill")
                                        Text(Helper.shared.timeFormatter(time: task.time ?? .now)).font(.system(size: 13))
                                    }
                                }
                                Spacer()
                                VStack {
                                    Image(uiImage: UIImage(data: task.pet?.image ?? Data()) ?? UIImage(systemName: "photo")!)
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 68, height: 68)
                                        .clipShape(Circle())
                                        .cornerRadius(10)
                                    Text(task.pet?.name ?? "").font(.system(size: 13, weight: .semibold))
                                }
                            }
                        }
                    }
                    .onDelete { IndexSet in
                        IndexSet.forEach { index in
                            let task = taskListViewModel.tasks[index]
                            taskListViewModel.deleteTask(task: task)
                        }
                    }
                }
            }
            .onAppear {
                taskListViewModel.fetchAllTasks()
            }
            .navigationBarTitle("Tarefas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddTaskView()
                    } label: {
                        Text("Adicionar")
                    }
                }
            })
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
