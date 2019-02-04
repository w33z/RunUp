//
//  Workout.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 11/11/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift
import CoreMotion

class Workout: Object {
    @objc dynamic var activity: ActivityOptions = Settings.instance.activity
    @objc dynamic var workout: WorkoutOptions = Settings.instance.workout
    var locations = List<Location>()
    @objc dynamic var distance: CLLocationDistance = 0
    @objc dynamic var steps: Int = 0
    @objc dynamic var speed: CLLocationSpeed = 0
    @objc dynamic var calories: Int = 0
    @objc dynamic var time: TimeInterval = 0
    @objc dynamic var date = Date()
    
    private var timer: Timer!
    private var pedometer: CMPedometer!
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerDidFire(_:)), userInfo: nil, repeats: true)
        pedometer = CMPedometer()
        
        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        }
    }
    
    func pause() {
        timer.invalidate()
    }
    
    func resume() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerDidFire(_:)), userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer.invalidate()
        timer = nil
        
        stopCountingSteps()
    }
    
    func save() throws {
        
        let realm = try Realm()
        
        try realm.write {
            realm.add(self)
        }
        
    }
    
    func setData(locations: [CLLocation]) {
        
        var speedArray = [CLLocationSpeed]()
        
        for location in locations {
            let locat = Location()
            locat.latitude = location.coordinate.latitude
            locat.longitude = location.coordinate.longitude
            self.locations.append(locat)
            
            speedArray.append(location.speed)
        }
        
        self.speed = speedArray.average
        
        
    }
    
    private func startCountingSteps() {
        guard let pedometer = self.pedometer else { return }
        
        pedometer.startUpdates(from: Date()) { (data, error) in
            guard let data = data, error == nil else { return }
            
            self.steps = data.numberOfSteps.intValue
        }
    }
    
    private func stopCountingSteps() {
        pedometer.stopUpdates()
        pedometer = nil
    }
    
    @objc fileprivate func timerDidFire(_ timer: Timer) {
        time += 1
        NotificationCenter.default.post(name: Notification.Name.WorkoutDidStartNotification, object: nil)
    }
}
