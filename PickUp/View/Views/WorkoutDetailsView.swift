//
//  WorkoutDetailsView.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 02/12/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import MapKit

class WorkoutDetailsView: UIView {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if Settings.instance.satellite {
            mapView.mapType = .hybridFlyover
        }
    }
    
    func configureView(workout: Workout) {
        stepsLabel.text = String(workout.steps)
        
        let speedUnit = Settings.instance.speed == .Mph ? "mph" : "km/h"
        let speed = workout.speed * (Settings.instance.speed == .Mph ? 2.2369 : 3.6)
        speedLabel.text = String(format: "%.1f", speed) + " \(speedUnit)"
        
        let distanceUnit = Settings.instance.distance == .Miles ? "mi." : "km."
        let distance = workout.distance * (Settings.instance.distance == .Miles ? 0.00062137 : 0.001)
        distanceLabel.text = String(format: "%.1f", distance) + " \(distanceUnit)"
        
        caloriesLabel.text = String(workout.calories)
        timeLabel.text = workout.time.getFormattedString()
    }
}
