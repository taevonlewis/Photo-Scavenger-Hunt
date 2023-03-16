//
//  Task.swift
//  Photo Scavenger Hunt
//
//  Created by TaeVon Lewis on 3/14/23.
//

import UIKit
import CoreLocation

class Task {
    let title: String
    let description: String
    var image: UIImage?
    var imageLocation: CLLocation?
    var isComplete: Bool {
        image != nil
    }
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    func set(_ image: UIImage, with location: CLLocation) {
        self.image = image
        self.imageLocation = location
    }
}

extension Task {
    static var mockedTasks: [Task] {
        return [
            Task(title: "Show light novels",
                 description: "Show my friends all of my light novels."),
            Task(title: "Take a pic of my new shoes",
                 description: "My mom asked for a picture of the new shoes I bought."),
            Task(title: "Turn on the candle wax machine",
                 description: "Make the room smell nice!")
        ]
    }
}
