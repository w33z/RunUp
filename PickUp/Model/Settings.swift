//
//  Settings.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 27/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation

enum SettingOptions: String {
    case Miles
    case Kilometers
    case Mph
    case Kmh
    case Fahrenheit
    case Celsius
}

enum ActivityOptions: String {
    case Walking
    case Running
    case Cycling
}

enum WorkoutOptions: String {
    case Tranning
    case Speed
    case Distance
}

class Settings {
    static let instance = Settings()
    
    var distance: SettingOptions = .Miles
    var speed: SettingOptions = .Mph
    var deegres: SettingOptions = .Fahrenheit
    var satellite = false
    
    var activity: ActivityOptions = .Walking {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.ActivityDidChangeNotification, object: nil)
        }
    }
    var workout: WorkoutOptions = .Tranning {
        didSet {
            
        }
    }
}
