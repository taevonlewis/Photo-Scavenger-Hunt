//
//  ImageAnnotationView.swift
//  Photo Scavenger Hunt
//
//  Created by TaeVon Lewis on 4/5/23.
//

import SwiftUI

struct ImageAnnotationView: View {
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
    }
}
