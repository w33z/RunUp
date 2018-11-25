//
//  WorkoutPanelView.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 24/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class WorkoutPanelView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startResumeButton: WorkoutButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: -5, height: 0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(activityDidChange), name: Notification.Name.ActivityDidChangeNotification, object: nil)
    }
    
    func configure(workout: Workout) {
        stepsLabel.text = String(workout.steps)
        
        let speedUnit = Settings.instance.speed == .Mph ? "mph" : "km/h"
        let speed = workout.speed * (Settings.instance.speed == .Mph ? 2.2369 : 3.6)
        speedLabel.text = String(format: "%.1f", speed) + " \(speedUnit)"
        
        let distanceUnit = Settings.instance.distance == .Miles ? "mi." : "km."
        let distance = workout.distance * (Settings.instance.distance == .Miles ? 0.00062137 : 0.001)
        distanceLabel.text = String(format: "%.1f", distance) + " \(distanceUnit)"
        
        caloriesLabel.text = String(workout.calories)
        timerLabel.text = workout.time.getFormattedString()
    }
    
    func reset() {
        stepsLabel.text = "0"
        
        let speedUnit = Settings.instance.speed == .Mph ? "mph" : "km/h"
        speedLabel.text = "0.0 \(speedUnit)"
        
        let unit = Settings.instance.distance == .Miles ? "mi." : "km."
        distanceLabel.text = "0.0 \(unit)"
        
        caloriesLabel.text = "0"
        timerLabel.text = "00:00:00"
        
        startResumeButton.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
}

extension WorkoutPanelView {
    
    @objc func activityDidChange() {
        titleLabel.text = Settings.instance.activity.name().uppercased()
    }
}

extension Notification.Name {
    static let ActivityDidChangeNotification = Notification.Name("ActivityDidChangeNotification")
}
