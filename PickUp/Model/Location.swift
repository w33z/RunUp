//
//  Location.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 24/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation

class Location {
    var latitude: Double
    var longitude: Double
    
    init() {
        self.latitude = 0
        self.longitude = 0
    }
    
    func setCordinates(_ latitude: Double, _ longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
