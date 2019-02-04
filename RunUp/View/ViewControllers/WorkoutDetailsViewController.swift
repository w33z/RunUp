//
//  WorkoutDetailsViewController.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 02/12/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class WorkoutDetailsViewController: BaseMenuViewController, LocationInjectorProtocol {
    
    private var workoutView: WorkoutDetailsView!
    var workout: Workout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutView = self.view as? WorkoutDetailsView
        
        if let workout = workout {
            workoutView.configureView(workout: workout)
        }
        
        setupNavigationBar()
        setupMap()
    }
}

extension WorkoutDetailsViewController {
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Workout details"
    }
    
    fileprivate func setupMap() {
        workoutView.mapView.delegate = self
        
        let locations = workout!.locations
        let coordinates = Array(locations.map({ $0.coordinate }))
        
        guard let first = coordinates.first, let last = coordinates.last else { return }

        let sourcePlacemark = MKPlacemark(coordinate: first)
        let destinationPlacemark = MKPlacemark(coordinate: last)
        
        let sourceAnnotation = MKPointAnnotation()
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }

        workoutView.mapView.showAnnotations([sourceAnnotation, destinationAnnotation], animated: true)
        
        let geodesic = MKGeodesicPolyline(coordinates: coordinates, count: coordinates.count)
        workoutView.mapView.addOverlay(geodesic, level: .aboveRoads)
        
         UIView.animate(withDuration: 1.5) {
            let rect = geodesic.boundingMapRect
            let offset = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
            let biggerRect = self.workoutView.mapView.mapRectThatFits(rect, edgePadding: offset)
            let region = MKCoordinateRegion(biggerRect)
            self.workoutView.mapView.setRegion(region, animated: true)
        }
    }
}

extension WorkoutDetailsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if let overlay = overlay as? MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.mapBlue
            polylineRenderer.lineWidth = 5
            
            return polylineRenderer
        }
        
        fatalError("Something wrong...")
    }
}
