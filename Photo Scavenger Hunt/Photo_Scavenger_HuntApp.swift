//
//  Photo_Scavenger_HuntApp.swift
//  Photo Scavenger Hunt
//
//  Created by TaeVon Lewis on 4/1/23.
//

import SwiftUI

@main
struct Photo_Scavenger_HuntApp: App {
    @StateObject private var taskViewModel = TaskViewModel()
    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environmentObject(taskViewModel)
        }
    }
}
