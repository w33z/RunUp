//
//  Event.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 21/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation

enum EventType: String {
    case registerButtonTappedEvent
    case registerSuccess
    case registerError
    case invalidRegisterFullname
    case invalidRegisterUsername
    case invalidRegisterEmail
    case invalidRegisterPassword
    case invalidRegisterGender
}

class Event {
    var type: EventType
    
    init(type: EventType) {
        self.type = type
    }
}
