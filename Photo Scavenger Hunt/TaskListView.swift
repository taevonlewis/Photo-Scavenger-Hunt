//
//  ContentView.swift
//  Photo Scavenger Hunt
//
//  Created by TaeVon Lewis on 4/1/23.
//

import SwiftUI

struct TaskListView: View {
    let tasks: [Task] = Task.mockedTasks
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    ZStack {
                        NavigationLink(destination: Text("placeholder")) {
                            EmptyView()
                        }
                        .opacity(0)
                        
                        HStack {
                            Text(task.title)
                            Spacer()
                            Image(systemName: task.isComplete ? "circle.fill" : "circle" )
                                .foregroundColor(task.isComplete ? .green : .primary)
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
