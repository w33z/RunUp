//
//  Settings.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 18/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import Firebase

class Settings {
    private static var _DB_BASE = Database.database().reference()
    private static var _REF_BASE = Settings.DB_BASE

    static var DB_BASE: DatabaseReference {
        return _DB_BASE
    }
        
    static var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
}

