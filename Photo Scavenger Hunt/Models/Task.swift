//
//  Task.swift
//  Photo Scavenger Hunt
//
//  Created by TaeVon Lewis on 4/2/23.
//

import SwiftUI
import CoreLocation
import CoreGraphics

struct Task {
    let title: String
    let description: String
    private(set) var image: CGImage?
    private(set) var imageLocation: CLLocation?
    var isComplete: Bool {
        image != nil
    }
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    mutating func set(_ image: CGImage, with location: CLLocation) {
        self.image = image
        self.imageLocation = location
    }
}
