//
//  MapView.swift
//  Photo Scavenger Hunt
//
//  Created by TaeVon Lewis on 4/5/23.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var location: CLLocationCoordinate2D
    var image: UIImage?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = CustomPointAnnotation()
        annotation.coordinate = location
        annotation.image = image
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        
        print("Location coordinates: \(location.latitude), \(location.longitude)")
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let customPointAnnotation = annotation as? CustomPointAnnotation else {
                return nil
            }
            
            let identifier = "customPin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            let imageAnnotation = ImageAnnotationView(image: customPointAnnotation.image ?? UIImage(systemName: "pin.fill")!)
            let hostingController = UIHostingController(rootView: imageAnnotation)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            hostingController.view.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            
            annotationView?.frame = hostingController.view.frame
            annotationView?.addSubview(hostingController.view)
            
            return annotationView
        }
    }
}

class CustomPointAnnotation: MKPointAnnotation {
    var image: UIImage?
}


