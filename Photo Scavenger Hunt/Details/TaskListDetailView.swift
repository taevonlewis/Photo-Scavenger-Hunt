//
//  TaskListDetailView.swift
//  Photo Scavenger Hunt
//
//  Created by TaeVon Lewis on 4/2/23.
//

import SwiftUI
import PhotosUI

struct TaskListDetailView: View {
    @Binding var task: Task
    @State private var showingPhotoPicker = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: task.isComplete ? "circle.fill" : "circle")
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
            if task.isComplete {
                if let image = task.image {
                    Image(uiImage: UIImage(cgImage: image))
                        .resizable()
                        .scaledToFit()
                }
            } else {
                Button(action: {
                    PHPhotoLibrary.requestAuthorization { status in
                        DispatchQueue.main.async {
                            if status == .authorized {
                                showingPhotoPicker = true
                            }
                        }
                    }
                }, label: {
                    Text("Attach Photo")
                        .foregroundColor(.white)
                        .font(.body)
                        .frame(maxWidth: .infinity)
                        .padding(.init(top: 7, leading: 0, bottom: 7, trailing: 0))
                        .background(RoundedRectangle(cornerRadius: 4))
                })
            }
        }
        .sheet(isPresented: $showingPhotoPicker) {
            PhotoPicker(image: Binding(get: {
                task.image.map { UIImage(cgImage: $0) }
            }, set: { image in
                if let image = image,
                   let cgImage = image.cgImage {
                    task.set(cgImage, with: CLLocation())
                    task.isComplete = task.image != nil
                } else {
                    task.image = nil
                }
            }))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding(.init(top: 10, leading: 25, bottom: 10, trailing: 25))
    }
}


struct TaskListDetailView_Previews: PreviewProvider {
    static var taskViewModel = TaskViewModel()
    
    static var previews: some View {
        let task = Task(title: "Show light novels", description: "Show my friends all of my light novels.")
        taskViewModel.tasks.append(task)
        
        return TaskListDetailView(task: .constant(taskViewModel.tasks[0]))
            .environmentObject(taskViewModel)
    }
}


