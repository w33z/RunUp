//
//  LocationInjectorProtocol.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 24/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation

protocol LocationInjectorProtocol {
    var location: Location { get }
}

fileprivate let sharedLocation: Location = Location()

extension LocationInjectorProtocol {
    
    var location: Location {
        return sharedLocation
    }
}
