//
//  TaskListDetailView.swift
//  Photo Scavenger Hunt
//
//  Created by TaeVon Lewis on 4/2/23.
//

import SwiftUI
import MapKit
import PhotosUI

struct TaskListDetailView: View {
    @Binding var task: Task
    @State private var showingPhotoPicker = false
    @State private var imageCoordinates: CLLocationCoordinate2D?
    @State private var image: UIImage?
    
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
                if let location = task.imageLocation, let image = task.image {
                    MapView(location: location.coordinate, image: UIImage(cgImage: image))
                        .frame(height: 200)
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
            PhotoPicker { (image, coordinates) in
                if let image = image,
                   let cgImage = image.cgImage {
                    let location = CLLocation(latitude: coordinates?.latitude ?? 0, longitude: coordinates?.longitude ?? 0)
                    task.set(cgImage, with: location)
                    task.isComplete = true
                    if let coordinates = coordinates {
                        print("Image coordinates set in TaskListDetailView: \(coordinates)")
                    } else {
                        print("Image coordinates not set in TaskListDetailView")
                    }
                } else {
                    task.image = nil
                }
            }
        }
        .onChange(of: task.isComplete) { newValue in
            if newValue {
                showingPhotoPicker = false
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding(.init(top: 10, leading: 25, bottom: 10, trailing: 25))
    }
    
    private func updateUI() {
        task.isComplete = task.image != nil
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


