//
//  Event.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 21/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation

enum EventType {
    case registerButtonTappedEvent
    case registerSuccess
    case registerError
    case invalidFullname
    case invalidUsername
    case invalidEmail
    case invalidPassword
    case invalidGender
    case loginButtonTappedEvent
    case loginSuccess
    case loginError
    case resetButtonTappedEvent
    case resetSuccess
    case resetError
}

class Event {
    var type: EventType
    
    init(type: EventType) {
        self.type = type
    }
}
