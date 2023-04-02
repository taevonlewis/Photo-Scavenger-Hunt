//
//  ContentView.swift
//  Photo Scavenger Hunt
//
//  Created by TaeVon Lewis on 4/1/23.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = Task.mockedTasks
}

struct TaskListView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(taskViewModel.tasks.indices), id: \.self) { index in
                    ZStack {
                        NavigationLink(destination: TaskListDetailView(task: $taskViewModel.tasks[index])) {
                            EmptyView()
                        }
                        .opacity(0)
                        
                        HStack {
                            Text(taskViewModel.tasks[index].title)
                            Spacer()
                            Image(systemName: taskViewModel.tasks[index].isComplete ? "circle.fill" : "circle" )
                                .foregroundColor(taskViewModel.tasks[index].isComplete ? .green : .primary)
                                .onReceive(taskViewModel.tasks[index].$isComplete, perform: { _ in
                                    taskViewModel.objectWillChange.send()
                                })
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Tasks")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
