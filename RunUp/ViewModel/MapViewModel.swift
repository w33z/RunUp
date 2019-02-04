//
//  MapViewModel.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 11/11/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import CoreLocation.CLLocation
import RealmSwift

class MapViewModel {
    
    var workout: Workout!
    var isPaused: Bool = false
    
    var locations = [CLLocation]()
    
    func startWorkout() {
        workout = Workout()
        workout.start()
    }
    
    func pauseWorkout() {
        workout.pause()
        isPaused = true
    }
    
    func resumeWorkout() {
        workout.resume()
        isPaused = false
    }
    
    func stopWorkout() {
        workout.stop()
        workout.setData(locations: locations)
        
        do {
            try workout.save()
        } catch {
            debugPrint(error)
        }
        
        workout = nil
        isPaused = false
        locations.removeAll()
    }
}

