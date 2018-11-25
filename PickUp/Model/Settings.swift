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

@objc enum ActivityOptions: Int {
    case Walking
    case Running
    case Cycling
    
    func name() -> String {
        switch self {
            case .Walking:
                return "Walking"
            case .Running:
                return "Running"
            case .Cycling:
                return "Cycling"
        }
    }
}

@objc enum WorkoutOptions: Int {
    case Tranning
    case Speed
    case Distance

    func name() -> String {
        switch self {
            case .Tranning:
                return "Tranning"
            case .Speed:
                return "Speed"
            case .Distance:
                return "Distance"
        }
    }
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
    var workout: WorkoutOptions = .Tranning
}
