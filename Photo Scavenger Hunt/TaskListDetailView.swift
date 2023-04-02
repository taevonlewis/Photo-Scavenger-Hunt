//
//  TaskListDetailView.swift
//  Photo Scavenger Hunt
//
//  Created by TaeVon Lewis on 4/2/23.
//

import SwiftUI

struct TaskListDetailView: View {
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: task.isComplete ? "circle.inset.fill" : "circle")
                    .font(.headline)
                    .foregroundColor(task.isComplete ? .green : .gray)
                Text(task.isComplete ? "Complete" : "Incomplete")
                    .font(.headline)
                    .foregroundColor(task.isComplete ? .green : .gray)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(task.title)
                    .font(.title2)
                Text(task.description)
                    .font(.body)
            }
            Button(action: {
                
                }, label: {
                Text("Attach Photo")
                    .foregroundColor(.white)
                    .font(.body)
                    .frame(maxWidth: .infinity)
                    .padding(.init(top: 7, leading: 0, bottom: 7, trailing: 0))
                    .background(RoundedRectangle(cornerRadius: 4))
            }
        )}
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding(.init(top: 10, leading: 25, bottom: 10, trailing: 25))
    }
}

struct TaskListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListDetailView(task: Task(title: "Show light novels",
                               description: "Show my friends all of my light novels."))
    }
}
