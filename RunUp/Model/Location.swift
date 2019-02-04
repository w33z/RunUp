//
//  Location.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 24/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import CoreLocation.CLLocation
import RealmSwift

class Location: Object {
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func setCordinates(_ latitude: Double, _ longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
